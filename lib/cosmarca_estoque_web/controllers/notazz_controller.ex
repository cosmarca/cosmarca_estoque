defmodule CosmarcaEstoqueWeb.NotazzController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Stocks.Notazz.NotazzInformation
  # alias CosmarcaEstoque.Accounts.User
  # alias CosmarcaEstoque.Accounts
  action_fallback CosmarcaEstoqueWeb.FallbackController
  alias CosmarcaEstoque.Stocks.Notazz.RegisterOutput
  alias CosmarcaEstoque.Stocks

  def create(conn, %{"xml" => xml, "pdf" => pdf, "statusNota" => statusNota}) do

    cond do
      statusNota == "Autorizada" ->
        nota = notazz_type(xml, nil, pdf)

        Stocks.list_products()
        |> Enum.find(&find_products(nota.product_name, &1.name))
        |> RegisterOutput.create_register(nota)

        conn
        |> put_status(:created)
        |> render("show.json", notazz: nota.product_name)

      true ->
        conn
        |> put_status(:created)
        |> render("show.json", notazz: "Erro ao processar a Nota")

    end


  end

  defp find_products(notazz_element_name, product_name) do
    String.contains?(String.downcase(notazz_element_name), String.downcase(product_name))
  end

  defp notazz_type(xml, rastreio, pdf) do
    {:ok, response} = HTTPoison.get(xml)
    response.body
    |> NotazzInformation.create(rastreio, pdf)
  end
end
