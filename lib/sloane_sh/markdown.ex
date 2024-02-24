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
  end

  def transform(%Context{} = ctx, data) when is_binary(data) do
    data
    |> FrontMatter.parse(ctx)
    |> parse_markdown(ctx)
  end

  defp parse_markdown({:ok, attrs, body}, _ctx) do
    with {:ok, html, msgs} <- Earmark.as_html(body) do
      for msg <- msgs, do: Logger.warning(msg)

      {:ok,
       %Markdown{
         attrs: attrs,
         html: html
       }}
    else
      {:error, _, msgs} ->
        for msg <- msgs, do: Logger.error(msg)
        :error

      _ ->
        :error
    end
  end

  defp parse_markdown(other, _ctx), do: other
end
