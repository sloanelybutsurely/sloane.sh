defmodule SloaneSH.Watch do
  use GenServer
  use TypedStruct
  require Logger

  alias SloaneSH.Build
  alias SloaneSH.Context
  alias SloaneSH.Layouts

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
          "lib/sloane_sh/layouts",
          ctx.config.pages_dir,
          ctx.config.posts_dir
        ]
      )

    :ok = FileSystem.subscribe(watcher_pid)

    Task.start_link(fn ->
      Tailwind.install_and_run(:default, ~w[--watch])
    end)

    Task.start_link(fn ->
      Esbuild.install_and_run(:default, ~w[--watch])
    end)

    state = %__MODULE__{ctx: ctx, watcher_pid: watcher_pid}

    {:ok, state, {:continue, :build}}
  end

  @impl GenServer
  def handle_continue(:build, %{ctx: ctx} = state) do
    Build.run(ctx)

    {:noreply, state}
  end

  @impl GenServer
  def handle_info({:file_event, pid, {path, _events}}, %{watcher_pid: pid} = state) do
    if String.match?(path, ~r/layouts/) do
      recompile_layouts()
    end

    ctx = Context.new()

    {:noreply, %{state | ctx: ctx}, {:continue, :build}}
  end

  @impl GenServer
  def handle_info({:file_event, pid, :stop}, %{watcher_pid: pid}) do
    Logger.warning("File watcher stopped")
    {:stop, :watcher_stopped, pid}
  end

  defp recompile_layouts do
    helpers_source = Layouts.Helpers.module_info(:compile)[:source] |> List.to_string()
    partials_source = Layouts.Partials.module_info(:compile)[:source] |> List.to_string()
    layouts_source = Layouts.module_info(:compile)[:source] |> List.to_string()

    {:ok, _, _} =
      Kernel.ParallelCompiler.compile([helpers_source, partials_source, layouts_source])

    :ok
  end
end
