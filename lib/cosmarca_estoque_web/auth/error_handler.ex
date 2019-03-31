defmodule CosmarcaEstoqueWeb.GuardianErrorHandler do
    import Plug.Conn
    import Phoenix.Controller
    alias CosmarcaEstoqueWeb.Router.Helpers
  
    @behaviour Guardian.Plug.ErrorHandler
  
    @impl Guardian.Plug.ErrorHandler
    def unauthenticated(conn, _params) do
      conn
      |> put_flash(:error, "Você precisa estar logado!")
      |> redirect(to: Routes.session_path(conn, :login))
      |> halt
    end
  end