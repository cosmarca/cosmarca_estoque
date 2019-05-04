defmodule CosmarcaEstoqueWeb.NotazzController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Stocks.Notazz.NotazzInformation
  # alias CosmarcaEstoque.Accounts.User
  # alias CosmarcaEstoque.Accounts
  action_fallback CosmarcaEstoqueWeb.FallbackController
  alias CosmarcaEstoque.Stocks.Notazz.RegisterOutput
alias CosmarcaEstoque.Stocks

  def create(conn, params) do
    %{"xml" => xml, "pdf" => pdf, "token" => token} = params

    nota = notazz_type(xml, nil, pdf)
    Stocks.get_product_by_name(nota.product_name)
    |> RegisterOutput.create_register(nota)

    # Accounts.get_user_by_token(token)

    # with {:ok, %Notazz{} = notazz} <- Notazzs.create_notazz(notazz_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.notazz_path(conn, :show, notazz))
      |> render("show.json", notazz: nil)
    # end
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
