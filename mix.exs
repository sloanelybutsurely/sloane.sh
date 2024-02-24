defmodule SloaneSH.MixProject do
  use Mix.Project

  def project do
    [
      app: :sloane_sh,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:file_system, "~> 1.0.0"},
      {:typed_struct, "~> 0.3.0"},
      {:earmark, "~> 1.4"},
      {:earmark_parser, "~> 1.4"},
      {:plug, "~> 1.15"},
      {:bandit, "~> 1.2"},
      {:tailwind, "~> 0.2"},
      {:toml, "~> 0.7"},
      {:esbuild, "~> 0.8"}
    ]
  end

  defp aliases do
    [
      "assets.deploy": ["tailwind default --minify"]
    ]
  end
end
