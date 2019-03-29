defmodule CosmarcaEstoqueWeb.PageController do
  use CosmarcaEstoqueWeb, :controller

  def secret(conn, _) do
    user = Guardian.Plug.current_resource(conn)
    IO.inspect user
    render(conn, "secret.html", current_user: user)
  end
  
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
