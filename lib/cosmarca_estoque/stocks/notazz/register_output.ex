defmodule CosmarcaEstoque.Stocks.Notazz.RegisterOutput do
    alias CosmarcaEstoque.Stocks.Notazz.Producs_Registers
    alias CosmarcaEstoque.Stocks

    @user_notazz_id 2

    def register do
        CosmarcaEstoque.Stocks.list_products |> CosmarcaEstoque.Repo.preload(:user)
        |> Enum.filter(&(&1.user.key_notazz != nil))
        |> Enum.map( &(create_register(&1)))
    end

    defp create_register(product) do
        Producs_Registers.products_registers(product)
        |> Enum.map(fn x -> 
            register = %{"input_quantity" => 0, "output_quantity" => x.sell_amount, "pdf" => x.pdf, "rastreio" => x.rastreio}
            Stocks.create_register(register, product.id, CosmarcaEstoque.Accounts.get_user!(@user_notazz_id)) end
            )
    end

end