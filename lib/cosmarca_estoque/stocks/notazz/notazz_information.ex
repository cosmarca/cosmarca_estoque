defmodule CosmarcaEstoque.Stocks.Notazz.NotazzInformation do
  import SweetXml


  defp notazz_map(xml_doc) do
    xpath(xml_doc,
    ~x"//infNFe"e,
    nNF: ~x"./ide/nNF/text()"s,
    client_name: ~x"./dest/xNome/text()"s,
    fancy_name: ~x"./emit/xFant/text()"s,
    business_name: ~x"./emit/xNome/text()"s,
    cnpj: ~x"./emit/CNPJ/text()"s,
    products: [~x"./det"l,
      name: ~x"./prod/xProd/text()"s,
      type: ~x"./prod/uCom/text()"s,
      amount: ~x"./prod/qCom/text()"f
    ]
    )
  end

  def create(xml_doc, rastreio, pdf) do
    notazz_map(xml_doc)
    # %CosmarcaEstoque.Stocks.Notazz.NotazzInformation{
    #   cnpj: xml_to_string(xml_doc, @cnpj),
    #   business_name: xml_to_string(xml_doc, @business_name),
    #   fancy_name: xml_to_string(xml_doc, @fancy_name),
    #   product_name: xml_to_string(xml_doc, @product_name),
    #   metric_type: xml_to_string(xml_doc, @metric_type),
    #   nNf: xml_to_string(xml_doc, @nNF),
    #   client_name: xml_to_string(xml_doc, @client_name),
    #   sell_amount: xml_to_integer(xml_doc, @sell_amount),
    #   rastreio: rastreio,
    #   pdf: pdf
    # }
  end

end
