defmodule CosmarcaEstoque.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string

      timestamps()
    end
    create(unique_index(:products, [:name]))
  end
end
