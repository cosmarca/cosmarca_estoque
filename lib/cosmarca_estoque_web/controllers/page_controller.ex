defmodule CosmarcaEstoqueWeb.PageController do
  use CosmarcaEstoqueWeb, :controller 
  def index(conn, _params) do
    # user = Guardian.Plug.current_resource(conn)
    render(conn, "index.html")
  end
end
