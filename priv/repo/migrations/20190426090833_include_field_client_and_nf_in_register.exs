defmodule CosmarcaEstoque.Repo.Migrations.IncludeFieldClientAndNfInRegister do
  use Ecto.Migration

  def change do
    alter table(:registers) do
      add :client_name, :string
      add :xNf, :string
    end
  end
end
