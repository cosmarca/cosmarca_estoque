defmodule CosmarcaEstoque.Stocks.Notazz.Producs_Registers do
    use HTTPoison.Base

    alias CosmarcaEstoque.Stocks.Notazz.NotazzInformation

    @url "https://app.notazz.com/api"
    @content_type  [{"Content-Type", "application/x-www-form-urlencoded"}]
    @expected_fields ~w(rastreio emissa xml statusNota)

    def products_registers(product) do
        intial_date = build_date(4, 01)
        final_date = build_date(3, 00)
        {:ok, response} = HTTPoison.post @url, process_body(product.user.key_notazz, intial_date, final_date), @content_type
        product_list = 
        response.body
        |> Poison.decode!
        |> Enum.map(fn {_id, note} -> 
            Map.take(note, @expected_fields) end)
        |> Enum.map( &(notazz_type(&1)) )
        |> Enum.filter( &(find_products(&1.product_name, product.name)) )
        product_list
    end
    
    def build_date(minus_hour, second) do
        date = DateTime.utc_now()
        "#{date.year}-#{date.month}-#{date.day}+#{date.hour - minus_hour}%3A00%3A#{second}"
    end

    defp find_products(notazz_element_name, product_name) do
         String.contains?(String.downcase(notazz_element_name),String.downcase(product_name))
    end

    defp notazz_type(note) do
        nota = %{"xml" => xml} = note
        {:ok, response } = HTTPoison.get(xml)
        response.body
        |> NotazzInformation.create()
    end 

    defp process_body(key, initial_date, final_date) do
        "fields=%7B%22API_KEY%22+%3A+%22#{key}%22%2C+%22METHOD%22%3A+%22consult_all_nfe_55%22%2C+%22FILTER%22%3A+%7B+%22STATUS%22+%3A%22Autorizada%22%2C+%22INITIAL_DATE%22%3A+%22#{initial_date}%22%2C+%22FINAL_DATE%22%3A+%22#{final_date}%22%7D%7D"
    end
    
end