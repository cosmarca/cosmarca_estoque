defmodule CosmarcaEstoque.Stocks.Notazz.RegisterOutput do
  alias CosmarcaEstoque.Stocks
  alias CosmarcaEstoque.Stocks.Products
  alias CosmarcaEstoque.Repo

  @user_notazz_id 2

  def create_register(nota) do
    nota.products
    |> Enum.map(fn produto ->


      Repo.get_by(Products, name: String.downcase("ClaryClean Amostra Gratis "))
      insert_product(produto, nota.pdf, nota.nNF, nota.client_name, nota.rastreio)
    end)
  end

  defp insert_product(produto, pdf, nNF, client_name, rastreio) do
    IO.inspect all_products
    product = Enum.find(all_products, &find_products(produto.name, &1.name))

    # produto_original = %{
    #   "input_quantity" => 0,
    #   "output_quantity" => Kernel.trunc(produto.amount),
    #   "pdf" => pdf,
    #   "nNf" => nNF,
    #   "client_name" => client_name,
    #   "rastreio" => rastreio
    # }
    # |> Stocks.create_register(
    #   product.id,
    #   CosmarcaEstoque.Accounts.get_user!(@user_notazz_id)
    # )
    # IO.inspect produto_original
    IO.inspect product.id
    # IO.inspect CosmarcaEstoque.Accounts.get_user!(@user_notazz_id)
  end

  def find_products(nota_product_name, product_name) do
    IO.inspect "d "<>product_name
    IO.inspect "x "<>nota_product_name
    nota_product_name = String.downcase(nota_product_name)
    product_name = String.downcase(product_name)

    cond do
      nota_product_name == product_name -> true
      String.contains?(nota_product_name, product_name) -> true
      true -> false
    end
  end
end
