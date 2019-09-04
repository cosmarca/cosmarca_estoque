defmodule CosmarcaEstoqueWeb.PageController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Stocks.ProductAmount

  def index(conn, _params) do
    current_user = conn.assigns.current_user

    case current_user.role do
      "admin" ->
        render(conn, "admin.html")

      _ ->
        products = CosmarcaEstoque.Stocks.list_products_by_user(current_user.id)

        products =
          Enum.map(products, fn x -> %{product: x, product_info: ProductAmount.product_info(x.register)} end)

        render(conn, "user.html", products: products)
    end
  end

end
