defmodule CosmarcaEstoque.Stocks.Products do
  use Ecto.Schema
  import Ecto.Changeset

  # @primary_key {:id, :binary_id, autogenerate: true}
  # @derive {Phoenix.Param, key: :id}
  schema "products" do
    field :name, :string
    belongs_to :user, CosmarcaEstoque.Accounts.User
    has_many :register, CosmarcaEstoque.Stocks.Register
    timestamps()
  end

  @doc false
  def changeset(products, attrs) do
    products
    |> cast(attrs, [:name])
    |> validate_required([:name], message: "Você deve inserir o nome do Produto")
    |> update_change(:name, &String.downcase(&1))
    |> unique_constraint(:name, message: "Já existe este produto!")
  end
end
