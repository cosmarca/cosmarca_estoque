defmodule FindRegister do
    use HTTPoison.Base
    import SweetXml

    defstruct cnpj: nil, nome_empresa: nil, nome_fantasia: nil, nome_produto: nil, tipo_unidade: nil, qt_compra: nil

    @url "https://app.notazz.com/api"
    @content_type  [{"Content-Type", "application/x-www-form-urlencoded"}]
    @expected_fields ~w(rastreio emissao xml)

    @key "gM4UTY3kDO2EjZhFTZlNjMwQjM4kTY2ETYlNWZxcTNipHd14ke5QVMuJGOyYzMhZzM2Q2Y2M2Y2AjN2E2MkFTMlVGOzUWYjRGNnZ"
    def find_register(intial_date, final_date) do
        {:ok, response} = HTTPoison.post @url, body_register(intial_date, final_date), @content_type
        response.body
        |> Poison.decode!
        |> Enum.map(fn {x, e} -> Map.take(e, @expected_fields) end)
        |> Enum.map(fn e ->  %{"xml" => xml} = e 
            {:ok, response } = HTTPoison.get xml
            doc = response.body
            find_product = String.downcase("Skin Renov - Creme Redutor de Estrias")
            # produto = to_string(doc |> xpath(~x"//infNFe/det/prod/xProd/text()"))
            # produco = String.downcase(produto)
            produto = String.downcase(to_string(doc |>  xpath(~x"//infNFe/det/prod/xProd/text()")))
            if String.contains?(produto, find_product) do

            %FindRegister{
               
                cnpj: doc |>  xpath(~x"//infNFe/emit/CNPJ/text()"), 
                nome_empresa: doc |>  xpath(~x"//infNFe/emit/xNome/text()"), 
                nome_fantasia: doc |>  xpath(~x"//infNFe/emit/xFant/text()"), 
                nome_produto: to_string(doc |>  xpath(~x"//infNFe/det/prod/xProd/text()")), 
                tipo_unidade: doc |>  xpath(~x"//infNFe/det/prod/uCom/text()"), 
                qt_compra:  doc |>  xpath(~x"//infNFe/det/prod/qCom/text()")
            }
         end
        end )
        # |> Map.take(@expected_fields)
        # |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
    end

    def body_register(intial_date, final_date) do
        "fields=%7B%22API_KEY%22+%3A+%22#{@key}%22%2C+%22METHOD%22%3A+%22consult_all_nfe_55%22%2C+%22FILTER%22%3A+%7B%22INITIAL_DATE%22%3A+%222019-04-08+08%3A00%3A00%22%2C+%22FINAL_DATE%22%3A+%222019-04-08+14%3A00%3A00%22%7D%7D"
    end
    
end