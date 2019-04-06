defmodule CosmarcaEstoqueWeb.PageController do
  use CosmarcaEstoqueWeb, :controller

  def index(conn, _params) do
    current_user = conn.assigns.current_user
    case current_user.role do
      "admin" ->
        render(conn, "admin.html")

      _ ->
        products = CosmarcaEstoque.Stocks.list_products_by_user(current_user.id)
        
        products = Enum.map products, fn x -> %{product: x, product_info:  product_info(x.register)} end

        render(conn, "user.html", products: products)
    end
  end

  defp product_info(register) do
    entrada = sum_in(register)
    saida = sum_out(register)
    percentage =cond do
      saida == 0 -> 100
      true -> 100  - ((saida * 100) / entrada)
    end
    %{qt_stock: entrada - saida, percentage_stock: percentage}
  end

  defp sum_in(registers), do: Enum.map(registers, fn y -> y.input_quantity end) |> Enum.sum
  defp sum_out(registers), do: Enum.map(registers, fn y -> y.output_quantity end) |> Enum.sum


end
