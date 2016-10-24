use Mix.Config

config :ex_nrel,
  api_key: System.get_env("NREL_API_KEY"),
  output: "json"
