defmodule Mix.Tasks.Site.Dev do
  @moduledoc "Build the site, watch for changes, and serve the built site"
  @shortdoc "run site.watch and site.serve"
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    Mix.Task.run("app.start")

    {:ok, watch_pid} =
      Task.start_link(fn ->
        Mix.Task.run("site.watch")
      end)

    {:ok, serve_pid} =
      Task.start_link(fn ->
        Mix.Task.run("site.serve")
      end)

    unless iex_running?() do
      watch_ref = Process.monitor(watch_pid)
      serve_ref = Process.monitor(serve_pid)

      receive do
        {:DOWN, ^watch_ref, _, _, _} ->
          :ok

        {:DOWN, ^serve_ref, _, _, _} ->
          :ok
      end
    end
  end

  defp iex_running? do
    Code.ensure_loaded?(IEx) and IEx.started?()
  end
end
