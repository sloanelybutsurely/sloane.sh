defmodule SloaneSH.Layouts.Partials do
  @moduledoc """
  HTML partials for use in HTML layouts
  """

  def header(_ctx) do
    ~s"""
    <header>
      <nav class="flex flex-row gap-2">
        <a href="/">home</a>
        <a href="/about">about</a>
      </nav>
    </header>
    """
  end
end
