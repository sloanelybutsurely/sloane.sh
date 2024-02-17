defmodule SloaneSH do
  @moduledoc """
  Sloane's personal static site generator powering [sloane.sh](https://sloane.sh).
  """

  alias SloaneSH.Build
  alias SloaneSH.Watch
  alias SloaneSH.Context

  def build(_opts \\ []) do
    context()
    |> Build.run()

    :ok
  end

  def watch(_opts \\ []) do
    context()
    |> Watch.start_link()
  end

  def context do
    Context.new()
    |> Context.init()
  end
end
