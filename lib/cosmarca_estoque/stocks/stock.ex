defmodule CosmarcaEstoque.Stocks.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stocks" do
    field :title, :string
    belongs_to :user, CosmarcaEstoque.Accounts.User
    has_many :register, CosmarcaEstoque.Stocks.Register
    timestamps()
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:title])
    |> validate_required([:title], message: "Já existe estoque com este nome")
    |> update_change(:title, &String.downcase(&1))
    |> unique_constraint(:title, message: "Já existe estoque com este nome")
    |> unique_constraint(:user_id, message: "Já existe estoque com este nome")
  end
end
