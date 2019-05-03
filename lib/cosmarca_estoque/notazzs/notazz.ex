defmodule CosmarcaEstoque.Notazzs.Notazz do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nota" do
    field :value, :string

    timestamps()
  end

  @doc false
  def changeset(notazz, attrs) do
    notazz
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
