defmodule SloaneSH.Watch do
  use GenServer
  use TypedStruct
  require Logger

  alias SloaneSH.Build
  alias SloaneSH.Context

  typedstruct do
    field :ctx, Context.t(), enforce: true
    field :watcher_pid, pid(), enforce: true
  end

  def start_link(%Context{} = ctx, opts \\ []) do
    GenServer.start_link(__MODULE__, ctx, opts)
  end

  @impl GenServer
  def init(%Context{} = ctx) do
    {:ok, watcher_pid} =
      FileSystem.start_link(
        dirs: [
          # ctx.config.layouts_dir,
          "priv/site/layouts",
          ctx.config.pages_dir,
          ctx.config.posts_dir
        ]
      )

    FileSystem.subscribe(watcher_pid)

    Tailwind.install_and_run(:default, ~w[--watch]) |> dbg()

    state = %__MODULE__{ctx: ctx, watcher_pid: watcher_pid}

    {:ok, state, {:continue, :build}}
  end

  @impl GenServer
  def handle_continue(:build, %{ctx: ctx} = state) do
    Build.run(ctx)

    {:noreply, state}
  end

  @impl GenServer
  def handle_info({:file_event, pid, {path, events}}, %{ctx: ctx, watcher_pid: pid} = state) do
    if String.match?(path, ~r/layouts/) do
      recompile_build()
      Build.run(ctx)
      {:noreply, state}
    else
      ctx = Context.maybe_add(ctx, path)

      if Context.in_context?(ctx, path) do
        path = Path.relative_to(path, ctx.config.pages_dir)
        Logger.info("File changed: #{path}")
        Build.build_page(ctx, path)
      end

      %{state | ctx: ctx}

      {:noreply, state}
    end
  end

  @impl GenServer
  def handle_info({:file_event, pid, :stop}, %{watcher_pid: pid}) do
    Logger.warning("File watcher stopped")
    {:stop, :watcher_stopped, pid}
  end

  defp recompile_build do
    build_source = Build.module_info(:compile)[:source] |> List.to_string()
    {:ok, _, _} = Kernel.ParallelCompiler.compile([build_source])

    :ok
  end
end