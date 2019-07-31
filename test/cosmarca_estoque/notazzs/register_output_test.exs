defmodule CosmarcaEstoque.Stocks.Notazz.RegisterOutputTest do
  use ExUnit.Case, async: true

  use CosmarcaEstoque.DataCase

  alias CosmarcaEstoque.Stocks.Notazz.RegisterOutput, as: Register

  import ExMock

  describe "should create nota in xml" do
    test "should insert all notaz" do
      {:ok, xml} = File.read("test/cosmarca_estoque/notazzs/nota.xml")
      nota = CosmarcaEstoque.Stocks.Notazz.NotazzInformation.create(xml, nil, nil)

      with_mock CosmarcaEstoque.Stocks, list_products: fn -> mock_list_products() end do
        CosmarcaEstoque.Stocks.list_products()

        with_mock CosmarcaEstoque.Accounts,
          get_user!: fn _id ->
            mock_user()
          end do
          CosmarcaEstoque.Accounts.get_user!(2)

          # with_mock CosmarcaEstoque.Stocks, create_register: fn _attrs, _products_id, _user -> registros() end do
            # CosmarcaEstoque.Stocks.create_register("oi", 2, 2)
            assert [1, 2] == Register.create_register(nota)
          # end
        end
      end
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
  end
end
