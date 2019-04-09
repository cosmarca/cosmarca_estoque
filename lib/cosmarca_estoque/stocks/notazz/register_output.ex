defmodule CosmarcaEstoque.Stocks.Notazz.RegisterOutput do
    alias CosmarcaEstoque.Stocks.Notazz.Producs_Registers
    alias CosmarcaEstoque.Stocks

    def register do
        products =  CosmarcaEstoque.Stocks.list_products |> CosmarcaEstoque.Repo.preload(:user)
        |> Enum.filter(&(&1.user.key_notazz != nil))
        |> Enum.map( &(create_register(&1)))
    end

    defp create_register(product) do
        Producs_Registers.products_registers(product, 1, 1)
        |> Enum.map(fn x -> 
            register = %{"input_quantity" => 0, "output_quantity" => x.sell_amount}
            Stocks.create_register(register, product.id, product.user) end
            )
        
    end

end