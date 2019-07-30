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

    defp mock_user() do
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

    defp mock_list_products() do
      [
        %CosmarcaEstoque.Stocks.Products{
          id: 1,
          inserted_at: ~N[2019-04-21 21:03:47],
          name: "ClaryClean",
          updated_at: ~N[2019-04-21 21:03:47],
          user_id: 3
        },
        %CosmarcaEstoque.Stocks.Products{
          id: 2,
          inserted_at: ~N[2019-04-21 21:03:47],
          name: "ClaryClean Amostra Gratis",
          updated_at: ~N[2019-04-21 21:03:47],
          user_id: 3
        }
      ]
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
