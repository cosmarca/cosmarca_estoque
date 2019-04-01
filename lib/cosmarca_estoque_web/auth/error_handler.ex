defmodule CosmarcaEstoqueWeb.Auth.GuardianErrorHandler do
    import Plug.Conn
    import Phoenix.Controller
    alias CosmarcaEstoqueWeb.Router.Helpers, as: Routes

    @behaviour Guardian.Plug.ErrorHandler

    @impl Guardian.Plug.ErrorHandler
    def auth_error(conn, {type, _reason}, _opts) do
      # body = to_string(type)
      conn
      |> redirect(to: Routes.session_path(conn, :new))
      |> halt
    end
  end
