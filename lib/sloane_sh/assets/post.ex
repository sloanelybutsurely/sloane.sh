defmodule SloaneSH.Assets.Post do
  use SloaneSH.Assets.Markdown, type: :post
  require Logger

  def handle_attrs(_cfg, path, _data, attrs) do
    unless Map.has_key?(attrs, :date) do
      Logger.warning("Post missing date property: #{inspect(path)}")
    end

    attrs
  end
end
