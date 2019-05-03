defmodule CosmarcaEstoqueWeb.NotazzController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Notazzs
  alias CosmarcaEstoque.Notazzs.Notazz

  action_fallback CosmarcaEstoqueWeb.FallbackController


  def create(conn, params) do
    %{"xml" => xml, "pdf" => pdf} = params
    IO.inspect xml
    IO.inspect pdf

    %{"chave" => "510807012123440001275500010000000981364117781",
    "clienteEmail" => "teste@exemplo.com", "emissao" => "2019-05-03 08:29:37",
    "external_id" => "66647020", "id" => "827ccb0eea8a706c4c34a16891f84e7b",
    "numero" => "123",
    "xml" => "https://app.notazz.com/docs/nfe/file.php?folder=xml/4dcae38ee11d3a6606cc6cd636a3628b|arquivo=NF-510807012123440001275500010000000981364117781.xml"}
    "statusNota" => "Autorizada", "tipo" => "nfe",
    # with {:ok, %Notazz{} = notazz} <- Notazzs.create_notazz(notazz_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.notazz_path(conn, :show, notazz))
      |> render("show.json", notazz: nil)
    # end
  end

end
