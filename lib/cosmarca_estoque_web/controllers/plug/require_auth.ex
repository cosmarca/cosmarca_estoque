defmodule CosmarcaEstoqueWeb.Plug.RequireAuth do
    import Plug.Conn
    import Phoenix.Controller
    alias CosmarcaEstoqueWeb.Router.Helpers
  
    def init(_params) do
    end
  
    def call(conn, _params) do
      if(conn.assigns[:user]) do
        conn
      else
        conn
        |> put_flash(:error, "Você precisa estar logado!")
        |> redirect(to: Helpers.page_path(conn, :index))
        |> halt
      end
    end
  end
  