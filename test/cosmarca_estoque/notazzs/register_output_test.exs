defmodule CosmarcaEstoque.Stocks.Notazz.RegisterOutputTest do
  use ExUnit.Case, async: true

  use CosmarcaEstoque.DataCase

  alias CosmarcaEstoque.Stocks.Notazz.RegisterOutput, as: Register
  import ExMock

  describe "should find products" do
    test "should get " do
      {:ok, xml} = File.read("test/cosmarca_estoque/notazzs/nota.xml")
      nota = CosmarcaEstoque.Stocks.Notazz.NotazzInformation.create(xml, nil, nil)
    end
  end

  def mock_user() do
    %CosmarcaEstoque.Accounts.User{
      business_name: "notazz@notazz.com",
      cnpj: "123444",
      email: "notazz@notazz.com",
      fancy_name: "notazz@notazz.com",
      first_name: "notazz@notazz.com",
      id: 2,
      inserted_at: ~N[2019-04-21 21:02:29],
      last_name: "notazz@notazz.com",
      password: nil,
      password_confirmation: nil,
      password_hash:
        "$argon2i$v=19$m=65536,t=6,p=1$UesGg1ht4/QLbCX93IqoYQ$ovrQXjSMwVv8xHyk/xccsEdsS+vgPONNPg+mINu61jY",
      role: "user",
      token: nil,
      updated_at: ~N[2019-04-21 21:02:29]
    }
  end

  # test "validate name contains" do
  #   produto = "Skin Renov"
  #   skin_renov_kit_3 = "Skin Renov - Kit 3"
  #   skin_renov = "Skin Renov - redutor"
  #   skin_renov_2 = "Skin Renov - Kit Max 3 "

  #   assert true == Register.find_products(skin_renov_kit_3, produto)
  #   assert true == Register.find_products(skin_renov, produto)
  #   assert true == Register.find_products(skin_renov_2, produto)
  # end

  # test "validate equals" do
  #   produto_amostra = "ClaryClean Amostra Gratis"
  #   clary_clean_amostra = "ClaryClean Amostra Gratis"
  #   clary_clean = "ClaryClean"
  #   produto = "ClaryClean"

  #   assert true == Register.find_products(clary_clean_amostra, produto_amostra)
  #   assert true == Register.find_products(clary_clean, produto)
  #   assert false == Register.find_products(clary_clean, "Clary Clean")
  # end
  # end
end
