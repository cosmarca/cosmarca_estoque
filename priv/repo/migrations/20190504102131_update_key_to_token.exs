defmodule CosmarcaEstoque.Repo.Migrations.UpdateKeyToToken do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :key_notazz, :string
      add :token, :string
    end
  end
end
