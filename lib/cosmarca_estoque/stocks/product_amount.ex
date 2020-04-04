defmodule CosmarcaEstoque.Stocks.ProductAmount do
  def product_info(register),
    do: %{qt_stock: qt_stock(register), percentage_stock: percentage_stock(register)}

  def qt_stock(register) do
    entrada = sum_in(register)
    saida = sum_out(register)
    entrada - saida
  end

  def percentage_stock(register) do
    entrada = sum_in(register)
    saida = sum_out(register)

    cond do
      entrada == 0 ->
        100

      saida == 0 ->
        100

      true ->
        100 - saida * 100 / entrada
    end
  end

  defp sum_in(registers), do: Enum.map(registers, fn y -> y.input_quantity end) |> Enum.sum()
  defp sum_out(registers), do: Enum.map(registers, fn y -> y.output_quantity end) |> Enum.sum()
end
