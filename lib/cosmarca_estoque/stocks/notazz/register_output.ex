defmodule CosmarcaEstoque.Stocks.Notazz.RegisterOutput do
  alias CosmarcaEstoque.Stocks
  @user_notazz_id 2

  def create_register(nota) do
    all_products = Stocks.list_products()

    nota.products
    |> Enum.map(fn produto ->
      insert_product(all_products, produto,
      nota.pdf, nota.nNF, nota.client_name, nota.rastreio)
    end)
  end

  defp insert_product(all_products, produto, pdf, nNF, client_name, rastreio) do
    product = Enum.find(all_products, &find_products(produto.name, &1.name))
    %{
      "input_quantity" => 0,
      "output_quantity" => Kernel.trunc(produto.amount),
      "pdf" => pdf,
      "nNf" => nNF,
      "client_name" => client_name,
      "rastreio" => rastreio
    }
    |> Stocks.create_register(
      product.id,
      CosmarcaEstoque.Accounts.get_user!(@user_notazz_id)
    )
  end

  def find_products(nota_product_name, product_name) do
    nota_product_name = String.downcase(nota_product_name)
    product_name = String.downcase(product_name)
    cond do
      nota_product_name == product_name -> true
      String.contains?(nota_product_name, product_name) -> true
      true -> false
    end
  end

end
