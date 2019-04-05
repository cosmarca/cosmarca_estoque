defmodule CosmarcaEstoqueWeb.PageController do
  use CosmarcaEstoqueWeb, :controller

  def index(conn, _params) do
    current_user = conn.assigns.current_user
    case current_user.role do
      "admin" ->
        render(conn, "admin.html")

      _ ->
        render(conn, "user.html", products: CosmarcaEstoque.Stocks.list_products_by_user(current_user.id))
    end
  end
end
