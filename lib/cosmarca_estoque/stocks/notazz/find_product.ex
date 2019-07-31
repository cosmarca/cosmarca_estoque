defmodule CosmarcaEstoque.Stocks.Notazz.FindProduct do
  alias CosmarcaEstoque.Stocks.Products
  alias CosmarcaEstoque.Repo
  import Ecto.Query


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
    Repo.all(from p in "products", where: like(p.name, ^"#{find}%"), select: %{"name": p.name, "id": p.id})
     case Enum.count(products_list) > 0 do
       true ->  filter_product(products_list, name)
       false -> {:error, "Producto nao encontrado"}
     end
  end

  defp filter_product(products_list, name) do
    product = Enum.find(products_list, &find_products(name, &1.name))
    {:ok, struct(Products, product)}
  end

  def find_products(nota_product_name, product_name) do
    nota_product_name = String.downcase(nota_product_name)
    product_name = String.downcase(product_name)
    String.contains?(nota_product_name, product_name)
  end

end
