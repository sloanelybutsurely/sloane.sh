defmodule SloaneSH.Watch do
  use GenServer
  require Logger

  def start_link(init_arg \\ [], opts \\ []) do
    GenServer.start_link(__MODULE__, init_arg, opts)
  end

  @impl GenServer
  def init([]) do
    dirs = [Path.join(:code.priv_dir(:sloane_sh), "site")]
    Logger.info("Watching #{inspect(dirs)} for changes")
    {:ok, pid} = FileSystem.start_link(dirs: dirs)
    FileSystem.subscribe(pid)

    {:ok, pid}
  end

  @impl GenServer
  def handle_info({:file_event, pid, {path, events}}, pid) do
    Logger.info("File event: #{inspect(path)} #{inspect(events)}")
    {:noreply, pid}
  end

  @impl GenServer
  def handle_info({:file_event, pid, :stop}, pid) do
    Logger.warning("File watcher stopped")
    {:stop, :watcher_stopped, pid}
  end
end
