defmodule SloaneSH.Layouts do
  @moduledoc """
  `EEx` based layouts
  """
  require EEx
  import SloaneSH.Layouts.Partials

  @layouts_dir Path.join(:code.priv_dir(:sloane_sh), "site/layouts")

  EEx.function_from_file(:def, :root, Path.join(@layouts_dir, "root.html.eex"), [
    :inner_content,
    :ctx,
    :attrs
  ])

  EEx.function_from_file(:defp, :page_layout, Path.join(@layouts_dir, "page.html.eex"), [
    :inner_content,
    :ctx,
    :attrs
  ])

  EEx.function_from_file(:defp, :post_layout, Path.join(@layouts_dir, "post.html.eex"), [
    :inner_content,
    :ctx,
    :attrs
  ])

  def page(inner_content, ctx, attrs) do
    inner_content
    |> page_layout(ctx, attrs)
    |> root(ctx, attrs)
  end

  def post(inner_content, ctx, attrs) do
    inner_content
    |> post_layout(ctx, attrs)
    |> root(ctx, attrs)
  end

  defp prefix_title(prefix, nil), do: prefix
  defp prefix_title(prefix, page_title), do: [prefix, " | ", page_title]
end
