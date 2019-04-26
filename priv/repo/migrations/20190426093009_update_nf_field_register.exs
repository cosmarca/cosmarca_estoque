defmodule CosmarcaEstoque.Repo.Migrations.UpdateNfFieldRegister do
  use Ecto.Migration

  def change do
    alter table :registers do
      remove :xNf
      add :nNf, :string
    end
  end
end
