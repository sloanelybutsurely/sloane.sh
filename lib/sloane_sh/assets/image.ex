defmodule SloaneSH.Assets.Image do
  alias SloaneSH.Asset
  alias SloaneSH.OutputDirs

  @behaviour Asset

  @impl Asset
  def extensions(_cfg), do: ~w[.jpg .jpeg .png .webp .gif]

  @impl Asset
  def attrs(_cfg, _path, _data) do
    {:ok, %{}}
  end

  @impl Asset
  def render(cfg, _ctx, path, data, _attrs) do
    {:ok, [{OutputDirs.image(cfg, path), data}]}
  end
end
