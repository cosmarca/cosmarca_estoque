defmodule CosmarcaEstoqueWeb.NotazzController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Notazzs
  alias CosmarcaEstoque.Notazzs.Notazz

  action_fallback CosmarcaEstoqueWeb.FallbackController


  def create(conn, params) do
    IO.inspect params
    # with {:ok, %Notazz{} = notazz} <- Notazzs.create_notazz(notazz_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.notazz_path(conn, :show, notazz))
      |> render("show.json", notazz: nil)
    # end
  end

end
