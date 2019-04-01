defmodule CosmarcaEstoqueWeb.Auth.CheckAdmin do
    import Phoenix.Controller
    import Plug.Conn
    import Guardian.Plug


    def init(opts), do: opts

    def call(conn, _opts) do
      current_user = Guardian.Plug.current_resource(conn)
      IO.puts "permissao check admin"
      IO.inspect Guardian.Plug.current_resource(conn).role
      case Guardian.Plug.current_resource(conn).role do
        "admin" -> conn
        _ -> 
            conn
            |> put_status(:not_found)
            |> render(CosmarcaEstoqueWeb.ErrorView, "404.html")
            |> halt
         end 
    end
end