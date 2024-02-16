defmodule Mix.Tasks.Site.Watch do
  @moduledoc "Build and output the site as HTML watching for changes"
  @shortdoc "build the site and watch for changes"
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    IO.puts("Starting site.watch...")

    {:ok, pid} = SloaneSH.watch()

    unless iex_running?() do
      ref = Process.monitor(pid)

      receive do
        {:DOWN, ^ref, _, _, _} ->
          IO.puts("site.watch terminated")
          :ok
      end
    end
  end

  defp iex_running? do
    Code.ensure_loaded?(IEx) and IEx.started?()
  end
end
