defmodule SloaneSH.Context do
  @moduledoc """
  A SloaneSH build context containing configuration and reference to content
  files.
  """
  use TypedStruct
  require Logger

  alias SloaneSH.Config
  alias SloaneSH.Asset
  alias SloaneSH.Assets.Page
  alias SloaneSH.Assets.Post
  alias SloaneSH.Assets.Image
  alias __MODULE__

  typedstruct do
    field :config, Config.t(), enforce: true
    field :pages, [Asset.t()], default: []
    field :posts, [Asset.t()], default: []
    field :images, [Asset.t()], default: []
  end

  def new(cfg \\ Config.default()) do
    pages = load_assets(cfg, Page, cfg.pages_dir)
    posts = load_assets(cfg, Post, cfg.posts_dir)
    images = load_assets(cfg, Image, cfg.images_dir)

    %Context{config: cfg, pages: pages, posts: posts, images: images}
  end

  defp load_assets(cfg, mod, src_dir) do
    exts = mod.extensions(cfg)

    for src <- collect_src_files(src_dir, exts) do
      contents = File.read!(src)

      case mod.attrs(cfg, src, contents) do
        {:ok, attrs, src_contents} ->
          %Asset{mod: mod, src: src, src_contents: src_contents, attrs: attrs}

        {:ok, attrs} ->
          %Asset{mod: mod, src: src, src_contents: contents, attrs: attrs}

        _ ->
          Logger.warning("Failed to parse attrs for #{inspect(src)}")
          %Asset{mod: mod, src: src, src_contents: contents, attrs: %{}}
      end
    end
  end

  defp collect_src_files(src_dir, exts) do
    files = src_dir |> File.ls!() |> Enum.map(&Path.join(src_dir, &1))
    {src_files, rest} = Enum.split_with(files, &String.ends_with?(&1, exts))

    other_dirs = Enum.filter(rest, &File.dir?/1)

    src_files ++ Enum.flat_map(other_dirs, &collect_src_files(&1, exts))
  end
end
