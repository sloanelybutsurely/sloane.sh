defmodule SloaneSH.Layouts.Helpers do
  alias SloaneSH.Context

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
    |> Enum.sort_by(& &1[:date], &Date.compare/2)
  end
end
