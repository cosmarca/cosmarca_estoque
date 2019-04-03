defmodule CosmarcaEstoque.Repo.Migrations.CreateRegisters do
  use Ecto.Migration

  def change do
    create table(:registers) do
      add :input_quantity, :string
      add :output_quantity, :string
      add :user_id, references(:users, on_delete: :delete_all)
      add :stock_id, references(:stocks, on_delete: :delete_all)
      add :products_id, references(:products, type: :uuid,  on_delete: :delete_all)
      
      timestamps()
    end

    alter table :stocks do
      add :register_id, references(:registers, on_delete: :delete_all)  
    end

    create index(:registers, [:products_id])
  end
end
