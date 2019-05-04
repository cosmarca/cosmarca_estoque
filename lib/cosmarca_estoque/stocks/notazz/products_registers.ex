defmodule CosmarcaEstoque.Stocks.Notazz.Producs_Registers do
  use HTTPoison.Base

  # @url "https://app.notazz.com/api"
  # @content_type [{"Content-Type", "application/x-www-form-urlencoded"}]
  # @expected_fields ~w( rastreio emissao xml statusNota pdf)

  # @spec products_registers(atom() | %{user: atom() | %{key_notazz: any()}}) :: [any()]
  # def products_registers(product) do
  #   # intial_date = build_date(8, 00, 00)
  #   # final_date = build_date(8, 59, 59)

  #   # {:ok, response} =
  #   #   HTTPoison.post(
  #   #     @url,
  #   #     process_body(product.user.key_notazz, intial_date, final_date),
  #   #     @content_type
  #   #   )

  #   # response.body
  #   # |> Poison.decode!()
  #   # |> Enum.map(fn {_id, note} -> Map.take(note, @expected_fields) end)
  #   # |> Enum.map(&notazz_type(&1))
  #   # |> Enum.filter(&find_products(&1.product_name, product.name))
  # end

  # def build_date(minus_hour, minute, second) do
  #   date = DateTime.utc_now()
  #   hour = date.hour - minus_hour

  #   {day, hour} =
  #     if hour < 0 do
  #       {date.day - 1, hour + 24}
  #     else
  #       {date.day, hour}
  #     end

  #   "#{date.year}-#{date.month}-#{day}+#{hour}%3A#{minute}%3A#{second}"
  # end

  # defp find_products(notazz_element_name, product_name) do
  #   String.contains?(String.downcase(notazz_element_name), String.downcase(product_name))
  # end

  # defp notazz_type(%{"xml" => xml, "rastreio" => rastreio, "pdf" => pdf}) do
  #   {:ok, response} = HTTPoison.get(xml)
  #   response.body
  #   |> NotazzInformation.create(rastreio, pdf)
  # end

  # defp process_body(key, initial_date, final_date) do
  #   body =
  #     "fields=%7B%22API_KEY%22+%3A+%22#{key}%22%2C+%22METHOD%22%3A+%22consult_all_nfe_55%22%2C+%22FILTER%22%3A+%7B+%22STATUS%22+%3A%22Autorizada%22%2C+%22INITIAL_DATE%22%3A+%22#{
  #       initial_date
  #     }%22%2C+%22FINAL_DATE%22%3A+%22#{final_date}%22%7D%7D"

  #   IO.inspect(initial_date)
  #   IO.inspect(final_date)
  #   IO.inspect(body)
  #   body
  # end
end
