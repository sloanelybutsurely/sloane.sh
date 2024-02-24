defmodule SloaneSH.Markdown do
  @moduledoc """
  Markdown parsing using `Earmark` and `Earmark.Parser`
  """
  require Logger
  use TypedStruct

  alias SloaneSH.Context
  alias SloaneSH.FrontMatter
  alias __MODULE__

  typedstruct do
    field :attrs, map(), default: %{}
    field :html, String.t(), default: ""
    field :text, String.t(), default: ""
  end

  def transform(%Context{} = ctx, data) when is_binary(data) do
    with {:ok, attrs, body} <- FrontMatter.parse(data, ctx),
         {:ok, html, msgs} <- Earmark.as_html(body),
         {:ok, html_tree} <- Floki.parse_fragment(html) do
      for msg <- msgs, do: Logger.warning(msg)

      {:ok,
       %Markdown{
         attrs: attrs,
         html: html,
         text: Floki.text(html_tree, sep: " ")
       }}
    else
      {:error, _, msgs} ->
        for msg <- msgs, do: Logger.error(msg)
        :error

      _ ->
        :error
    end
  end
end
