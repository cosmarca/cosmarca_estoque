defmodule CosmarcaEstoque.Stocks.Notazz.NotazzInformationTest do
  use CosmarcaEstoque.DataCase

  describe "should create nota in xml" do
    test "should read NF" do
      {:ok, xml} = File.read("test/cosmarca_estoque/notazzs/nota.xml")

      assert %{
               business_name: "LHT INTERMEDIACAO DE NEGOCIOS DIGITAL LTDA",
               client_name: "ROSILANE SCOPEL",
               cnpj: "29654819000154",
               fancy_name: "LHT DIGITAL",
               nNF: "182",
               products: [
                 %{amount: 1.0, name: "ClaryClean Amostra Gratis", type: "UN"},
                 %{amount: 3.0, name: "ClaryClean", type: "UN"}
               ],
               pdf: nil,
               rastreio: nil
             } == CosmarcaEstoque.Stocks.Notazz.NotazzInformation.create(xml, nil, nil)
    end
  end

  test "should read NF with one product" do
    {:ok, xml} = File.read("test/cosmarca_estoque/notazzs/nota2.xml")

    assert %{
             business_name: "LHT INTERMEDIACAO DE NEGOCIOS DIGITAL LTDA",
             cnpj: "29654819000154",
             fancy_name: "LHT DIGITAL",
             pdf: nil,
             rastreio: nil,
             client_name: "Solene Antunes Macedo Alves",
             nNF: "9514",
             products: [%{type: "UN", amount: 2.0, name: "ClaryClean"}]
           } == CosmarcaEstoque.Stocks.Notazz.NotazzInformation.create(xml, nil, nil)
  end
end
