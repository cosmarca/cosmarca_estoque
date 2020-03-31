defmodule CosmarcaEstoque.Stocks.Notazz.FindProduct do
  alias CosmarcaEstoque.Stocks.Products
  alias CosmarcaEstoque.Repo
  import Ecto.Query
  alias CosmarcaEstoque.Stocks.Notazz.FilterProduct, as: Filter

  def find_by(name) do
    name = String.downcase(name)
    product = Repo.get_by(Products, name: name)

    cond do
      product != nil -> {:ok, product}
      product == nil -> filter_product(name)
    end
  end

  defp filter_product(name) do
    {find, _rest} = String.split_at(name, 4)

    products_list =
      Repo.all(
        from p in "products", where: like(p.name, ^"#{find}%"), select: %{name: p.name, id: p.id}
      )

    case Enum.count(products_list) > 0 do
      true -> Filter.filter_product(products_list, name)
      false -> {:error, "Producto nao encontrado"}
    end
  end
end
