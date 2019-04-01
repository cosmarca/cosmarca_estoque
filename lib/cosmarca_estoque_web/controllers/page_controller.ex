defmodule CosmarcaEstoqueWeb.PageController do
  use CosmarcaEstoqueWeb, :controller 
  
  def index(conn, _params) do
    case conn.assigns.current_user.role do
      "admin" ->     
          render(conn, "admin.html")
      _ ->
          render(conn, "user.html")
    end
  end

end
