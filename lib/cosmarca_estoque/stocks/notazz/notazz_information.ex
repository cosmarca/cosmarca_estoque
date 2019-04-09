defmodule CosmarcaEstoque.Stocks.Notazz.NotazzInformation do
    import SweetXml

    defstruct cnpj: nil, business_name: nil, 
    fancy_name: nil, product_name: nil, metric_type: nil, sell_amount: nil

    @cnpj ~x"//infNFe/emit/CNPJ/text()"
    @business_name ~x"//infNFe/emit/xNome/text()"
    @fancy_name ~x"//infNFe/emit/xFant/text()"
    @product_name ~x"//infNFe/det/prod/xProd/text()"
    @metric_type ~x"//infNFe/det/prod/uCom/text()"
    @sell_amount ~x"//infNFe/det/prod/qCom/text()"

    def create(xml_doc) do
        %CosmarcaEstoque.Stocks.Notazz.NotazzInformation{
            cnpj: xml_to_string(xml_doc, @cnpj), 
            business_name: xml_to_string(xml_doc, @business_name), 
            fancy_name: xml_to_string(xml_doc, @fancy_name), 
            product_name: xml_to_string(xml_doc, @product_name), 
            metric_type: xml_to_string(xml_doc, @metric_type), 
            sell_amount:  xml_to_integer(xml_doc,  @sell_amount)
        }
    end

    defp xml_to_integer(xml_doc, path) do
         [value | _ ] = String.codepoints(xml_to_string(xml_doc, path))
         String.to_integer(value)
    end

    defp xml_to_string(xml_doc, path) do
        to_string(xml_doc |>  xpath(path))
    end

end