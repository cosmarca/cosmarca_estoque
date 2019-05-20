# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cosmarca_estoque,
  ecto_repos: [CosmarcaEstoque.Repo]

# Configures the endpoint
config :cosmarca_estoque, CosmarcaEstoqueWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cK8oAozuaMMYK00Jq/ZQptZ+ba00FC3G5oijyinO9AyACezQTaiRRCJknrg7eqH3",
  render_errors: [view: CosmarcaEstoqueWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: CosmarcaEstoque.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  level: :debug,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# config :cosmarca_estoque, CosmarcaEstoque.Scheduler,
#   jobs: [
#     phoenix_job: [
#       schedule: "*/60 * * * *",
#       task: {CosmarcaEstoque.Task, :work, []}
#     ]
#   ]

config :cosmarca_estoque, CosmarcaEstoqueWeb.Auth.Guardian,
  issuer: "cosmarca_estoque",
  secret_key: "lFp3x36MlY2xktFApHKLewZcJm4eyRD4pgLrzsGXhG4UI4VtPNzYD5qVtm907p3B"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
