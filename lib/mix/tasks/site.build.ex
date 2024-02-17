defmodule Mix.Tasks.Site.Build do
  @moduledoc "Build and output the site as HTML"
  @shortdoc "build the site"
  use Mix.Task
  require Logger

  alias SloaneSH.Format

  @impl Mix.Task
  def run(_args) do
    Mix.Task.run("app.start")
    {micro, :ok} = :timer.tc(&SloaneSH.build/0)
    Logger.info("Built site in #{Format.time(micro)}")
  end
end
