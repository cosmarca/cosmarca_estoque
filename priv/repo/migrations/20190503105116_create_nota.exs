defmodule CosmarcaEstoque.Repo.Migrations.CreateNota do
  use Ecto.Migration

  def change do
    create table(:nota) do
      add :value, :string

      timestamps()
    end
  end
end
