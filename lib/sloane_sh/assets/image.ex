defmodule SloaneSH.Assets.Image do
  alias SloaneSH.Asset
  alias SloaneSH.OutputDirs

  @behaviour Asset

  @impl Asset
  def extensions(_cfg), do: ~w[.jpg .jpeg .png .webp .gif]

  @impl Asset
  def attrs(_cfg, _path, data) do
    {:ok, image} = Image.from_binary(data)

    aspect = Image.aspect(image)
    {width, height, _} = Image.shape(image)

    {:ok, %{aspect: aspect, width: width, height: height}, image}
  end

  @impl Asset
  def render(cfg, _ctx, path, data, _attrs) do
    formats = ~w[.webp .png .jpg]

    outputs =
      for format <- formats do
        format_path = OutputDirs.replace_ext(path, format)
        output_path = OutputDirs.image(cfg, format_path)

        {:ok, converted} =
          Image.write(data, :memory,
            suffix: format,
            strip_metadata: true,
            minimize_file_size: true,
            quality: 80
          )

        {output_path, converted}
      end

    {:ok, outputs}
  end
end
