defmodule CosmarcaEstoque.Stocks.Register do
  use Ecto.Schema
  import Ecto.Changeset

  schema "registers" do
    field :input_quantity, :integer
    field :output_quantity, :integer
    belongs_to :stock, CosmarcaEstoque.Stocks.Stock
    belongs_to :products, CosmarcaEstoque.Stocks.Products
    belongs_to :user, CosmarcaEstoque.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(register, attrs) do
    register
    |> cast(attrs, [:input_quantity, :output_quantity])
    |> validate_required([:input_quantity, :output_quantity])
  end
end
