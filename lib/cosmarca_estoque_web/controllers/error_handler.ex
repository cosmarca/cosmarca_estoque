defmodule CosmarcaEstoqueWeb.ErrorHandler do
    import Plug.Conn
    import Phoenix.Controller
    alias ChatWeb.Router.Helpers
  
    @behaviour Guardian.Plug.ErrorHandler
  
    @impl Guardian.Plug.ErrorHandler
    def auth_error(conn, {type, _reason}, _opts) do
      body = to_string(type)
      conn
      # |> put_flash(:error, "Você precisa estar logado!")
      |> redirect(to: "/login")
      |> halt
    end
  end