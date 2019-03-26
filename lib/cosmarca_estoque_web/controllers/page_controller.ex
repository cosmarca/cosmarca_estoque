defmodule CosmarcaEstoqueWeb.PageController do
  use CosmarcaEstoqueWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
