defmodule SloaneSH.Assets.Markdown do
  @moduledoc """
      Helper to define markdown, html, and eex templating for pages and posts
  """
  defmacro __using__(opts) do
    type = Keyword.fetch!(opts, :type)

    quote do
      alias SloaneSH.Asset
      alias SloaneSH.FrontMatter
      alias SloaneSH.Layouts
      alias SloaneSH.OutputDirs

      @behaviour Asset

      @impl Asset
      def extensions(_cfg), do: ~w[.md .html .md.eex .html.eex]

      @impl Asset
      def attrs(cfg, path, data) do
        {:ok, attrs, without_attrs} = FrontMatter.parse(data)

        attrs =
          Map.put_new_lazy(attrs, :permalink, fn ->
            output = apply(OutputDirs, unquote(type), [cfg, path])
            permalink = OutputDirs.to_permalink(cfg, output)
          end)

        attrs = handle_attrs(cfg, path, without_attrs, attrs)

        {:ok, attrs, without_attrs}
      end

      @impl Asset
      def render(cfg, ctx, path, data, attrs) do
        output_path =
          if attrs[:permalink] do
            OutputDirs.from_permalink(cfg, attrs[:permalink])
          else
            apply(OutputDirs, unquote(type), [cfg, path])
          end

        output = {output_path, do_render(ctx, path, data, attrs)}
        {:ok, [output]}
      end

      defp do_render(ctx, path, data, attrs) when is_binary(path) do
        do_render(ctx, base_and_ext(path), data, attrs)
      end

      defp do_render(ctx, {path, ".eex"}, data, attrs) do
        eexed = EEx.eval_string(data, ctx: ctx, attrs: attrs)
        do_render(ctx, base_and_ext(path), eexed, attrs)
      end

      defp do_render(ctx, {path, ".md"}, data, attrs) do
        html = Earmark.as_html!(data)
        do_render(ctx, {path, ".html"}, html, attrs)
      end

      defp do_render(ctx, {_path, ".html"}, data, attrs) do
        apply(Layouts, unquote(type), [data, ctx, attrs])
      end

      defp base_and_ext(path) do
        ext = Path.extname(path)
        base = Path.basename(path, ext)
        {base, ext}
      end

      def handle_attrs(cfg, path, data, attrs) do
        attrs
      end

      defoverridable handle_attrs: 4
    end
  end
end
