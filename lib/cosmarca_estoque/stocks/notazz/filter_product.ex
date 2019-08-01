defmodule CosmarcaEstoque.Stocks.Notazz.FilterProduct do
  alias CosmarcaEstoque.Stocks.Products


  def filter_product(products_list, name) do
    product = Enum.find(products_list, &find_products(name, &1.name))
    {:ok, struct(Products, product)}
  end

  def find_products(nota_product_name, product_name) do
    nota_product_name = String.downcase(nota_product_name)
    product_name = String.downcase(product_name)
    String.contains?(nota_product_name, product_name)
  end
end
