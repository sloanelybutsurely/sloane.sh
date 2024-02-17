defmodule SloaneSH.Config do
  @moduledoc """
  SloaneSH configuration
  """
  use TypedStruct

  alias __MODULE__

  typedstruct do
    field :pages_dir, String.t(), enforce: true
    field :posts_dir, String.t(), enforce: true
    field :output, String.t(), enforce: true
  end

  def default do
    priv = :code.priv_dir(:sloane_sh) |> resolve_link()

    %Config{
      pages_dir: Path.join(priv, "site/pages"),
      posts_dir: Path.join(priv, "site/posts"),
      output: Path.join(priv, "output")
    }
  end

  def in_config?(%Config{} = cfg, path) do
    Enum.any?([cfg.pages_dir, cfg.posts_dir], &String.starts_with?(path, &1)) and
      Path.extname(path) == ".md"
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
