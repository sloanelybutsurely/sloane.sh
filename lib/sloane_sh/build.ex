defmodule SloaneSH.Build do
  require Logger
  require EEx

  alias SloaneSH.Context
  alias SloaneSH.Markdown
  alias SloaneSH.Write

  @layouts_dir Path.join(:code.priv_dir(:sloane_sh), "site/layouts")

  EEx.function_from_file(:def, :root_layout, Path.join(@layouts_dir, "root.html.eex"), [
    :ctx,
    :inner_content
  ])

  def run(%Context{} = ctx) do
    ctx
    |> build_pages()
    |> build_posts()
  end

  def build_pages(%Context{} = ctx) do
    Logger.info("Building pages...")
    for page <- ctx.pages, do: build_page(ctx, page)

    ctx
  end

  def build_posts(%Context{} = ctx) do
    Logger.info("Building posts...")
    for post <- ctx.posts, do: build_post(ctx, post)

    ctx
  end

  def build_page(%Context{} = ctx, page) do
    path = Path.join(ctx.config.pages_dir, page)

    with {:ok, data} <- File.read(path),
         {:ok, inner_content} <- Markdown.transform(ctx, data),
         html = root_layout(ctx, inner_content),
         :ok <- Write.page(ctx, page, html) do
      Logger.info("Built page: #{page}")
    else
      err -> Logger.error("Failed to build page #{page}: #{inspect(err)}")
    end
  end

  def build_post(%Context{} = ctx, post) do
    path = Path.join(ctx.config.posts_dir, post)

    with {:ok, data} <- File.read(path),
         {:ok, html} <- Markdown.transform(ctx, data),
         :ok <- Write.post(ctx, post, html) do
      Logger.info("Built post: #{post}")
    else
      err -> Logger.error("Failed to build post #{post}: #{inspect(err)}")
    end
  end
end
