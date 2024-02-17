defmodule SloaneSH.Context do
  @moduledoc """
  A SloaneSH build context containing configuration and reference to content
  files.
  """
  use TypedStruct

  alias SloaneSH.Config
  alias __MODULE__

  typedstruct do
    field :config, Config.t(), enforce: true
    field :pages, [String.t()], default: []
    field :posts, [String.t()], default: []
  end

  def new(config \\ Config.default()) do
    %Context{config: config}
  end

  def init(%Context{config: config} = context) do
    with {:ok, pages_contents} <- File.ls(config.pages_dir),
         {:ok, posts_contents} <- File.ls(config.posts_dir) do
      pages = Enum.filter(pages_contents, &String.match?(&1, ~r/.*\.md$/))
      posts = Enum.filter(posts_contents, &String.match?(&1, ~r/.*\.md$/))
      %Context{context | pages: pages, posts: posts}
    end
  end

  def maybe_add(%Context{config: config} = ctx, path) do
    if Config.in_config?(config, path) do
      cond do
        String.starts_with?(path, config.pages_dir) ->
          page = Path.relative_to(path, config.pages_dir)
          %{ctx | pages: Enum.uniq([page | ctx.pages])}

        String.starts_with?(path, config.posts_dir) ->
          post = Path.relative_to(path, config.posts_dir)
          %{ctx | posts: Enum.uniq([post | ctx.posts])}

        true ->
          ctx
      end
    else
      ctx
    end
  end

  def in_context?(%Context{config: config, pages: pages, posts: posts}, path) do
    with true <- Config.in_config?(config, path) do
      cond do
        String.starts_with?(path, config.pages_dir) ->
          page = Path.relative_to(path, config.pages_dir)

          [page in pages]

        String.starts_with?(path, config.posts_dir) ->
          post = Path.relative_to(path, config.posts_dir)

          [post in posts]

        true ->
          false
      end
    end
  end
end
