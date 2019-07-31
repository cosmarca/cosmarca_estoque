defmodule CosmarcaEstoque.Stocks.Notazz.ListProducts do

  def mock_list_products() do
    [
      %CosmarcaEstoque.Stocks.Products{
        id: 1,
        inserted_at: ~N[2019-04-21 21:03:47],
        name: "ClaryClean",
        updated_at: ~N[2019-04-21 21:03:47],
        user_id: 3
      },
      %CosmarcaEstoque.Stocks.Products{
        id: 2,
        inserted_at: ~N[2019-04-21 21:03:47],
        name: "ClaryClean Amostra Gratis",
        updated_at: ~N[2019-04-21 21:03:47],
        user_id: 3
      }
    ]
  end
end
