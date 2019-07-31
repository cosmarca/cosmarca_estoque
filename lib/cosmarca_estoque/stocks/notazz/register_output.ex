defmodule CosmarcaEstoque.Stocks.Notazz.RegisterOutput do

  alias CosmarcaEstoque.Stocks.Notazz.FindProduct
  alias CosmarcaEstoque.Stocks

  @user_notazz_id 2

  def create_register(nota, pdf) do
    nota.products
    |> Enum.map(fn product_nota ->
      {registro, id, dono} = FindProduct.find_by(product_nota.name)
      |> register(pdf, nota.nNF, nota.client_name, nil )

      Stocks.create_register(registro, id, dono)

    end)
  end

  defp register(produto, pdf, nNF, client_name, rastreio) do
    {%{
      "input_quantity" => 0,
      "output_quantity" => Kernel.trunc(produto.amount),
      "pdf" => pdf,
      "nNf" => nNF,
      "client_name" => client_name,
      "rastreio" => rastreio
    }, produto.id, CosmarcaEstoque.Accounts.get_user!(@user_notazz_id)}
  end

end
