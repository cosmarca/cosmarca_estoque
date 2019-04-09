defmodule CosmarcaEstoque.Repo.Migrations.IncludeNewFieldsForUser do
  use Ecto.Migration

  def change do
    alter table :users do
      add :key_notazz, :string
      add :cnpj, :string
      add :business_name, :string
      add :fancy_name, :string
    end
  end
end
