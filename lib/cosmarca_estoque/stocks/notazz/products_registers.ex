defmodule CosmarcaEstoque.Stocks.Notazz.Producs_Registers do
  use HTTPoison.Base

  alias CosmarcaEstoque.Stocks.Notazz.NotazzInformation

  @url "https://app.notazz.com/api"
  @content_type [{"Content-Type", "application/x-www-form-urlencoded"}]
  @expected_fields ~w( rastreio emissao xml statusNota pdf)

  @spec products_registers(atom() | %{user: atom() | %{key_notazz: any()}}) :: [any()]
  def products_registers(product) do
    intial_date = build_date(7, 01)
    final_date = build_date(6, 00)

    {:ok, response} =
      HTTPoison.post(
        @url,
        process_body(product.user.key_notazz, intial_date, final_date),
        @content_type
      )

    response.body
    |> Poison.decode!()
    |> Enum.map(fn {_id, note} -> Map.take(note, @expected_fields) end)
    |> Enum.map(&notazz_type(&1))
    |> Enum.filter(&find_products(&1.product_name, product.name))
  end

  @spec build_date(number(), any()) :: <<_::64, _::_*8>>
  def build_date(minus_hour, second) do
    date = DateTime.utc_now()
    hour = date.hour - minus_hour
    hour = if hour  <  0 do hour + 24 else hour end
    "#{date.year}-#{date.month}-#{date.day}+#{hour}%3A00%3A#{second}"
  end

  defp find_products(notazz_element_name, product_name) do
    String.contains?(String.downcase(notazz_element_name), String.downcase(product_name))
  end

  defp notazz_type(%{"xml" => xml, "rastreio" => rastreio, "pdf" => pdf}) do
    {:ok, response} = HTTPoison.get(xml)

    response.body
    |> NotazzInformation.create(rastreio, pdf)
  end

  defp process_body(key, initial_date, final_date) do
    body = "fields=%7B%22API_KEY%22+%3A+%22#{key}%22%2C+%22METHOD%22%3A+%22consult_all_nfe_55%22%2C+%22FILTER%22%3A+%7B+%22STATUS%22+%3A%22Autorizada%22%2C+%22INITIAL_DATE%22%3A+%22#{
      initial_date
    }%22%2C+%22FINAL_DATE%22%3A+%22#{final_date}%22%7D%7D"
    IO.inspect initial_date
    IO.inspect final_date
    IO.inspect body
    body
  end
end
