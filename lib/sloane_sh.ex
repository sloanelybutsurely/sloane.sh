defmodule SloaneSH do
  @moduledoc """
  Sloane's personal static site generator powering [sloane.sh](https://sloane.sh).
  """

  def build(_opts \\ []) do
    :ok
  end

  def watch(_opts \\ []) do
    Task.start_link(fn ->
      Process.sleep(5_000)
    end)
  end
end
