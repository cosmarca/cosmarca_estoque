defmodule CosmarcaEstoqueWeb.NotazzController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Stocks.Notazz.NotazzInformation
  action_fallback CosmarcaEstoqueWeb.FallbackController
  alias CosmarcaEstoque.Stocks.Notazz.RegisterOutput

  def create(conn, %{"xml" => xml, "pdf" => pdf, "statusNota" => statusNota}) do

    cond do
      statusNota == "Autorizada" ->
        nota = notazz_type(xml, nil, pdf)
        RegisterOutput.create_register(nota)
        mensagemRetorno(conn, nota.nNF)
      true ->
        mensagemRetorno(conn, "Nao Autorizada")
    end


  end

  defp mensagemRetorno(conn, msg) do
    conn
    |> put_status(:created)
    |> render("show.json", notazz: msg)
  end

  defp notazz_type(xml, rastreio, pdf) do
    {:ok, response} = HTTPoison.get(xml)
    response.body
    |> NotazzInformation.create(rastreio, pdf)
  end
end
