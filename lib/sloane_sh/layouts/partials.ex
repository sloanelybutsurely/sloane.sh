defmodule SloaneSH.Layouts.Partials do
  @moduledoc """
  HTML partials for use in HTML layouts
  """
  require EEx

  EEx.function_from_string(
    :def,
    :header,
    ~S"""
    <header class="flex flex-row justify-between gap-2 border-b border-neutral-700 pb-4 mb-2" data-pagefind-ignore>
      <div class="flex flex-col gap-2">
        <a href="/"><h1 class="text-2xl">sloane.sh</h1></a>
        <nav class="flex flex-row gap-2 text-xl">
          <a href="/" class="<%= cx(underline: attrs[:permalink] == "/") %>">home</a>
          <a href="/posts" class="<%= cx(underline: Map.get(attrs, :permalink, "") =~ ~r[^/posts]) %>">posts</a>
          <a href="/search" class="<%= cx(underline: attrs[:permalink] == "/search") %>">search</a>
        </nav>
      </div>
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
