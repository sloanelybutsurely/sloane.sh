defmodule SloaneSH.Build do
  require Logger

  alias SloaneSH.Context

  def run(%Context{} = ctx) do
    assets = ctx.posts ++ ctx.pages ++ ctx.images

    File.mkdir_p!(ctx.config.output_dir)

    for asset <- assets do
      case asset.mod.render(ctx.config, ctx, asset.src, asset.src_contents, asset.attrs) do
        {:ok, output_files} ->
          for {dest, content} <- output_files do
            with :ok <- dest |> Path.dirname() |> File.mkdir_p(),
                 :ok <- File.write(dest, content) do
              Logger.info("Wrote #{inspect(dest)}.")
            else
              {:error, err} ->
                Logger.error("Failed to write #{inspect(dest)}, #{inspect(err)}")
            end
          end

        err ->
          Logger.error("Failed to render #{inspect(asset.src)}, #{inspect(err)}")
      end
    end

    :ok
  end
end
