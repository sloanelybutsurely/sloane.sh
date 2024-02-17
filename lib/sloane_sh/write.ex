defmodule SloaneSH.Write do
  def page(ctx, src, data) do
    path = md_to_html(src)

    write(ctx, path, data)
  end

  def post(ctx, src, data) do
    path = Path.join("posts", md_to_html(src))

    write(ctx, path, data)
  end

  def write(ctx, name, data) do
    path = Path.join(ctx.config.output, name)

    with :ok <- File.mkdir_p(Path.dirname(path)) do
      File.write(path, data)
    end
  end

  def md_to_html("index.md"), do: "index.html"

  def md_to_html(path) do
    dir = Path.dirname(path)
    base = Path.basename(path, ".md")

    case dir do
      "." -> Path.join(base, "index.html")
      _ -> Path.join([dir, base, "index.html"])
    end
  end
end
