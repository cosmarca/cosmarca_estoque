defmodule CosmarcaEstoque.Stocks.Notazz.RegisterOutput do
  alias CosmarcaEstoque.Stocks

  @user_notazz_id 2

  # def register do
  #   CosmarcaEstoque.Stocks.list_products()
  #   |> CosmarcaEstoque.Repo.preload(:user)
  #   |> Enum.filter(&(&1.user.key_notazz != nil))
  #   |> Enum.map(&create_register(&1))
  # end

  def create_register(product, nota) do
    # Producs_Registers.products_registers(product)
    # |> Enum.map(fn x ->
      register = %{
        "input_quantity" => 0,
        "output_quantity" => nota.sell_amount,
        "pdf" => nota.pdf,
        "nNf" => nota.nNf,
        "client_name" => nota.client_name,
        "rastreio" => nota.rastreio
      }
      Stocks.create_register(
        register,
        product.id,
        CosmarcaEstoque.Accounts.get_user!(@user_notazz_id)
      )
    # end)
  end
end
