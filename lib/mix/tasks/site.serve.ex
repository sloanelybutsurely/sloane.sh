defmodule Mix.Tasks.Site.Serve do
  @moduledoc "Serve the built site. Only for use in development"
  @shortdoc "serve the built site"
  use Mix.Task
  require Logger

  @impl Mix.Task
  def run(_args) do
    Mix.Task.run("app.start")
    Logger.info("Starting development server...")

    {:ok, pid} = SloaneSH.serve()

    unless iex_running?() do
      ref = Process.monitor(pid)

      receive do
        {:DOWN, ^ref, _, _, _} ->
          Logger.info("Development server terminated")
          :ok
      end
    end
  end

  defp iex_running? do
    Code.ensure_loaded?(IEx) and IEx.started?()
  end
end
