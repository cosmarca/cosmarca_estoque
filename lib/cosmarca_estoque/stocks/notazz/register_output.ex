defmodule CosmarcaEstoque.Stocks.Notazz.RegisterOutput do
  alias CosmarcaEstoque.Stocks.Notazz.FindProduct
  alias CosmarcaEstoque.Stocks

  @user_notazz_id 2

  def create_register(nota, pdf) do
    nota.products
    |> Enum.map(fn product_nota ->
      case FindProduct.find_by(product_nota.name) do
        {:ok, product} ->
          register = register(product_nota, pdf, nota.nNF, nota.client_name, nil)
          Stocks.create_register(register, product.id, CosmarcaEstoque.Accounts.get_user!(@user_notazz_id))
        {:error, msg} -> msg
      end
    end)
  end

  defp register(produto, pdf, nNF, client_name, rastreio) do
    %{
       "input_quantity" => 0,
       "output_quantity" => Kernel.trunc(produto.amount),
       "pdf" => pdf,
       "nNf" => nNF,
       "client_name" => client_name,
       "rastreio" => rastreio
     }
  end
end
