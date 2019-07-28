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

  defstruct nNF: nil, client_name: nil, fancy_name: nil,
  business_name: nil, cnpj: nil, products: nil

  def create(xml_doc, rastreio, pdf) do
    Map.put(notazz_map(xml_doc), :rastreio, rastreio)
    |> Map.put(:pdf, pdf)
  end

end
