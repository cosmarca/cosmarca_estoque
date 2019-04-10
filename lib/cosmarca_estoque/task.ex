defmodule CosmarcaEstoque.Task do
    
    def work do
        IO.inspect "Hora executada"
        IO.inspect DateTime.utc_now()
        CosmarcaEstoque.Stocks.Notazz.RegisterOutput.register()
    end
end