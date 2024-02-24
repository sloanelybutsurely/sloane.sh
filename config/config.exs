import Config

config :logger, :default_formatter, format: "$time $metadata[$level] $message\n"

config :tailwind,
  version: "3.4.1",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/output/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :esbuild,
  version: "0.20.1",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/output/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{ "NODE_PATH" => Path.expand("../deps", __DIR__) }
  ]
