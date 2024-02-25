defmodule SloaneSH.Layouts.Partials do
  @moduledoc """
  HTML partials for use in HTML layouts
  """
  require EEx
  import SloaneSH.Layouts.Helpers, warn: false

  EEx.function_from_string(
    :def,
    :header,
    ~S"""
    <header class="flex flex-row justify-between gap-2 pb-4 mb-2" data-pagefind-ignore>
    <div class="flex flex-col justify-end">
        <%= if attrs[:title] do %>
          <h1 class="text-3xl font-extrabold"><%= attrs[:title] %></h1>
        <% end %>
      </div>
      <div class="flex flex-col gap-2 items-end">
        <a href="/"><span class="text-lg font-bold">sloane.sh</span></a>
        <nav class="flex flex-row gap-2">
          <a href="/" class="<%= cx(underline: attrs[:permalink] == "/") %>">home</a>
          <a href="/posts" class="<%= cx(underline: Map.get(attrs, :permalink, "") =~ ~r[^/posts]) %>">posts</a>
          <a href="/search" class="<%= cx(underline: attrs[:permalink] == "/search") %>">search</a>
        </nav>
      </div>
    </header>
    """,
    [:ctx, :attrs]
  )
end
