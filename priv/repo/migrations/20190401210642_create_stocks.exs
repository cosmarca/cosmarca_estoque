defmodule CosmarcaEstoque.Repo.Migrations.CreateStocks do
  use Ecto.Migration

  def change do
    create table(:stocks) do
      add :title, :string
      add :user_id, references(:users, on_delete: :delete_all)
      timestamps()
    end
    create index(:stocks, [:user_id])
    create(unique_index(:stocks, [:title, :user_id]))
  end
end
