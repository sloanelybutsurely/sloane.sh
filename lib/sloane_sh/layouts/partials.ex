defmodule SloaneSH.Layouts.Partials do
  @moduledoc """
  HTML partials for use in HTML layouts
  """
  require EEx

  EEx.function_from_string(
    :def,
    :header,
    ~S"""
      <header class="flex flex-col gap-2">
        <a href="/"><h1 class="text-xl">sloane.sh</h1></a>
        <nav class="flex flex-row gap-2">
          <a href="/" class="<%= cx(underline: attrs[:permalink] == "/") %>">home</a>
          <a href="/about" class="<%= cx(underline: attrs[:permalink] == "/about") %>">about</a>
        </nav>
      </header>
    """,
    [:ctx, :attrs]
  )

  defp cx(classes) do
    classes
    |> Enum.map(fn
      {_, _} = t -> t
      c -> {c, true}
    end)
    |> Enum.filter(fn {_, v} -> !!v end)
    |> Enum.map_join(" ", fn {class, _} -> class end)
  end
end
