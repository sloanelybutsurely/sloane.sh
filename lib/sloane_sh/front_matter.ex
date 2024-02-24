defmodule SloaneSH.FrontMatter do
  @moduledoc """
  Parses TOML front matter out put files
  """

  def parse("+++" <> rest, _ctx) do
    [toml, body] = String.split(rest, ["+++\n", "+++\r\n"], parts: 2)

    with {:ok, attrs} <- Toml.decode(toml, keys: :atoms) do
      {:ok, attrs, body}
    end
  end

  def parse(body, _ctx) do
    {:ok, %{}, body}
  end
end
