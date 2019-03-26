defmodule CosmarcaEstoque.Repo do
  use Ecto.Repo,
    otp_app: :cosmarca_estoque,
    adapter: Ecto.Adapters.Postgres
end
