defmodule CosmarcaEstoque.Stocks.Notazz.RegisterOutput do
  alias CosmarcaEstoque.Stocks

  @user_notazz_id 2

  def create_register(product, nota) do
    %{
      "input_quantity" => 0,
      "output_quantity" => nota.sell_amount,
      "pdf" => nota.pdf,
      "nNf" => nota.nNf,
      "client_name" => nota.client_name,
      "rastreio" => nota.rastreio
    }
    |> Stocks.create_register(
      product.id,
      CosmarcaEstoque.Accounts.get_user!(@user_notazz_id)
    )
  end
end
