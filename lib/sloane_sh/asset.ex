defmodule SloaneSH.Asset do
  use TypedStruct
  alias SloaneSH.Config
  alias SloaneSH.Context

  typedstruct do
    field :mod, module(), enforce: true
    field :src, String.t(), enforce: true
    field :src_contents, binary(), enforce: true
    field :attrs, map(), enforce: true
  end

  @callback extensions(cfg :: Config.t()) :: [String.t()]

  @callback attrs(cfg :: Config.t(), path :: String.t(), data :: binary()) ::
              {:ok, map(), without_attrs :: binary()} | {:ok, map()} | :error | {:error, term()}

  @callback render(
              cfg :: Config.t(),
              ctx :: Context.t(),
              path :: String.t(),
              data :: binary(),
              attrs :: map()
            ) ::
              {:ok, [{dest :: String.t(), binary()}]} | :error | {:error, term()}
end
