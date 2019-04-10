defmodule CosmarcaEstoqueWeb.Auth.CheckAdmin do
  import Phoenix.Controller
  import Plug.Conn
  alias CosmarcaEstoqueWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _opts) do
    case Guardian.Plug.current_resource(conn).role do
      "admin" ->
        conn

      _ ->
        conn
        |> put_flash(:error, "Você não tem permissao para executar esta operação")
        |> redirect(to: Routes.page_path(conn, :index))
        |> halt
    end
  end
end
