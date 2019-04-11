defmodule CosmarcaEstoque.Repo.Migrations.UpdateRegisterPdfRastreio do
  use Ecto.Migration

  def change do
    alter table :registers do
      add :pdf, :string
      add :rastreio, :string
    end
  end
end
