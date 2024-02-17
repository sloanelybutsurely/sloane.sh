defmodule SloaneSH.Markdown do
  @moduledoc """
  Markdown parsing using `Earmark` and `Earmark.Parser`
  """
  require Logger

  alias SloaneSH.Context

  def transform(%Context{} = _ctx, data) when is_binary(data) do
    case Earmark.as_html(data) do
      {:ok, html_doc, deprecation_messages} ->
        for msg <- deprecation_messages, do: Logger.warning(msg)

        {:ok, html_doc}

      {:error, html_doc, error_messages} ->
        for msg <- error_messages, do: Logger.error(msg)
        {:error, html_doc}
    end
  end
end
