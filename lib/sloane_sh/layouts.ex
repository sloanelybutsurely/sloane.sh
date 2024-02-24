defmodule SloaneSH.Layouts do
  @moduledoc """
  `EEx` based layouts
  """
  require EEx
  import SloaneSH.Layouts.Partials

  @layouts_dir Path.join(:code.priv_dir(:sloane_sh), "site/layouts")

  EEx.function_from_file(:def, :root_layout, Path.join(@layouts_dir, "root.html.eex"), [
    :ctx,
    :attrs,
    :inner_content
  ])

  EEx.function_from_file(:def, :page_layout, Path.join(@layouts_dir, "page.html.eex"), [
    :ctx,
    :attrs,
    :inner_content
  ])

  EEx.function_from_file(:def, :post_layout, Path.join(@layouts_dir, "post.html.eex"), [
    :ctx,
    :attrs,
    :inner_content
  ])

  defp prefix_title(prefix, nil), do: prefix
  defp prefix_title(prefix, page_title), do: [prefix, " | ", page_title]
end
