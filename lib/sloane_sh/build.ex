defmodule SloaneSH.Build do
  require Logger

  alias SloaneSH.Context
  alias SloaneSH.Layouts
  alias SloaneSH.Markdown
  alias SloaneSH.Write

  def run(%Context{} = ctx) do
    ctx
    |> build_pages()
    |> build_posts()
    |> copy_img()
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
      {:ok, md} <- Markdown.transform(ctx, data),
         contents = Layouts.page_layout(ctx, md.attrs, md.html),
         html = Layouts.root_layout(ctx, md.attrs, contents),
         :ok <- Write.page(ctx, page, html) do
      Logger.info("Built page: #{page}")
    else
      err -> Logger.error("Failed to build page #{page}: #{inspect(err)}")
    end
  end

  def build_post(%Context{} = ctx, post) do
    path = Path.join(ctx.config.posts_dir, post)

    with {:ok, data} <- File.read(path),
      {:ok, md} <- Markdown.transform(ctx, data),
         contents = Layouts.post_layout(ctx, md.attrs, md.html),
         html = Layouts.root_layout(ctx, md.attrs, contents),
         :ok <- Write.post(ctx, post, html) do
      Logger.info("Built post: #{post}")
    else
      err -> Logger.error("Failed to build post #{post}: #{inspect(err)}")
    end
  end

  def copy_img(%Context{} = ctx) do
    ctx
  end
end
