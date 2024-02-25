defmodule SloaneSH.Layouts.Helpers do
  require Logger
  alias SloaneSH.Context
  alias SloaneSH.OutputDirs

  def cx(classes) do
    classes
    |> Enum.map(fn
      {_, _} = t -> t
      c -> {c, true}
    end)
    |> Enum.filter(fn {_, v} -> !!v end)
    |> Enum.map_join(" ", fn {class, _} -> class end)
  end

  def sorted_post_attrs(%Context{} = ctx) do
    ctx.posts
    |> Enum.map(& &1.attrs)
    |> Enum.sort_by(& &1[:date], {:desc, Date})
  end

  def fmt_date(date) do
    Timex.format!(date, "{Mfull} {D}, {YYYY}")
  end

  def picture(ctx, src, alt \\ "", class \\ "") do
    image =
      Enum.find(ctx.images, fn i ->
        output = OutputDirs.image(ctx.config, i.src)
        src == OutputDirs.to_permalink(ctx.config, output)
      end)

    if is_nil(image) do
      Logger.warning("Could not find #{inspect(src)} to make picture element")
      ~s|<img src="#{src}" alt="#{alt}" class="#{class}">|
    else
      [{_, src} | srcsets] =
        [
          {"image/jpg", ".jpg"},
          {"image/webp", ".webp"},
          {"image/png", ".png"}
        ]
        |> Enum.map(fn {type, ext} ->
          {type, OutputDirs.replace_ext(src, ext)}
        end)

      EEx.eval_string(
        ~S"""
        <picture class="<%= class %>">
          <%= for {type, srcset} <- srcsets do %>
            <source srcset="<%= srcset %>" type="<%= type %>" />
          <% end %>
          <img src="<%= src %>" alt="<%= alt %>" />
        </picture>
        """,
        src: src,
        srcsets: srcsets,
        alt: alt,
        class: class
      )
    end
  end
end
