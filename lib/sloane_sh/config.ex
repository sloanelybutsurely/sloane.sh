defmodule SloaneSH.Config do
  @moduledoc """
  SloaneSH configuration
  """
  use TypedStruct

  alias __MODULE__

  typedstruct do
    field :pages_dir, String.t(), enforce: true
    field :posts_dir, String.t(), enforce: true
    field :images_dir, String.t(), enforce: true
    field :output_dir, String.t(), enforce: true
  end

  def default do
    priv = :code.priv_dir(:sloane_sh) |> resolve_link()

    %Config{
      pages_dir: Path.join(priv, "site/pages"),
      posts_dir: Path.join(priv, "site/posts"),
      images_dir: Path.join(priv, "site/images"),
      output_dir: Path.join(priv, "output")
    }
  end

  defp resolve_link(path) do
    case File.read_link(path) do
      {:ok, link} ->
        dir = Path.dirname(path)
        Path.expand(link, dir)

      _ ->
        path
    end
  end
end
