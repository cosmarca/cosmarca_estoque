defmodule CosmarcaEstoque.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :user_id, references(:users, on_delete: :delete_all)
      timestamps()
    end
    create(unique_index(:products, [:name]))
  end
end
