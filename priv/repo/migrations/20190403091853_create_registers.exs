defmodule CosmarcaEstoque.Repo.Migrations.CreateRegisters do
  use Ecto.Migration

  def change do
    create table(:registers) do
      add :input_quantity, :integer
      add :output_quantity, :integer
      add :user_id, references(:users, on_delete: :delete_all)
      add :products_id, references(:products, on_delete: :delete_all)

      timestamps()
    end
    create index(:registers, [:products_id])
  end
end
