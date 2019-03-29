defmodule CosmarcaEstoqueWeb.PageController do
  use CosmarcaEstoqueWeb, :controller

  def secret(conn, _) do
    IO.inspect conn.private[:guardian_default_resource]
    user = Guardian.Plug.current_resource(conn)
    render(conn, "secret.html", current_user: user)
  end
  
  def index(conn, _params) do
    render(conn, "index.html")
  end
end
