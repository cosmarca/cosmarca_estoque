use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cosmarca_estoque, CosmarcaEstoqueWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :cosmarca_estoque, CosmarcaEstoque.Repo,
  username: "postgres",
  password: "1234",
  database: "cosmarca_estoque_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
