defmodule Mix.Tasks.Site.Build do
  @moduledoc "Build and output the site as HTML"
  @shortdoc "build the site"
  use Mix.Task

  alias SloaneSH.Format

  @impl Mix.Task
  def run(_args) do
    {micro, :ok} = :timer.tc(&SloaneSH.build/0)
    IO.puts("built site in #{Format.time(micro)}")
  end
end
