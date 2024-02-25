defmodule SloaneSH.OutputDirs do
  def page(cfg, src) do
    path = Path.relative_to(src, cfg.pages_dir)

    cfg.output_dir |> Path.join(path) |> prettify_html_path()
  end

  def post(cfg, src) do
    path = Path.relative_to(src, cfg.posts_dir)
    path = Path.join("post", path)

    cfg.output_dir |> Path.join(path) |> prettify_html_path()
  end

  def image(cfg, src) do
    path = Path.relative_to(src, cfg.images_dir)
    path = Path.join("assets/images", path)

    cfg.output_dir |> Path.join(path)
  end

  def prettify_html_path(path) do
    file = Path.basename(path)
    [without_extension | _] = String.split(file, ".", parts: 2)

    suffix =
      if without_extension == "index" do
        "index.html"
      else
        Path.join(without_extension, "index.html")
      end

    String.replace_suffix(path, file, suffix)
  end

  def to_permalink(cfg, output_path) do
    output_path
    |> Path.relative_to(cfg.output_dir)
    |> String.trim_trailing("index.html")
    |> String.replace_prefix("", "/")
    |> String.trim_trailing("/")
  end

  def from_permalink(cfg, permalink) do
    Path.join([cfg.output_dir, permalink, "/index.html"])
  end

  def replace_ext(path, new_ext) do
    ext = Path.extname(path)
    base = Path.basename(path, ext)
    dir = Path.dirname(path)

    Path.join(dir, base <> new_ext)
  end
end
