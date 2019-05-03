defmodule CosmarcaEstoqueWeb.NotazzController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Stocks.Notazz.NotazzInformation

  action_fallback CosmarcaEstoqueWeb.FallbackController


  def create(conn, params) do
    %{"xml" => xml, "pdf" => pdf, "token" => token} = params
    IO.inspect "=====token"
    IO.inspect token
    IO.inspect notazz_type(xml, nil, pdf)

    # with {:ok, %Notazz{} = notazz} <- Notazzs.create_notazz(notazz_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.notazz_path(conn, :show, notazz))
      |> render("show.json", notazz: nil)
    # end
  end

  defp notazz_type(xml, rastreio, pdf) do
    {:ok, response} = HTTPoison.get(xml)
    response.body
    |> NotazzInformation.create(rastreio, pdf)
  end

end
