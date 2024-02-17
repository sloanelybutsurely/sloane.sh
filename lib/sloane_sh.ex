defmodule SloaneSH do
  @moduledoc """
  Sloane's personal static site generator powering [sloane.sh](https://sloane.sh).
  """

  alias SloaneSH.Build
  alias SloaneSH.Context
  alias SloaneSH.Serve
  alias SloaneSH.Watch

  def build(_opts \\ []) do
    context()
    |> Build.run()

    :ok
  end

  def watch(_opts \\ []) do
    context()
    |> Watch.start_link()
  end

  def serve do
    context()
    |> Serve.start_link()
  end

  def context do
    Context.new()
    |> Context.init()
  end
end
