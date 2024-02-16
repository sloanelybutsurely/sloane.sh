defmodule SloaneSH do
  @moduledoc """
  Sloane's personal static site generator powering [sloane.sh](https://sloane.sh).
  """

  def build(_opts \\ []) do
    :ok
  end

  def watch(_opts \\ []) do
    SloaneSH.Watch.start_link()
  end
end
