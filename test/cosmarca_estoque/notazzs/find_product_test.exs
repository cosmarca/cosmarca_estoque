defmodule CosmarcaEstoque.Stocks.Notazz.FindProductTest do
  use ExUnit.Case, async: true

  use CosmarcaEstoque.DataCase

  alias CosmarcaEstoque.Stocks.Notazz.FindProduct, as: Find
  import ExMock

  describe "should find products" do
    test "should get success" do
      with_mock CosmarcaEstoque.Repo, get_by: fn _struct, _name -> claryclean_amostra() end do
        Repo.get_by(Products, name: "ClaryClean Amostra Gratis")

        expected =
          {:ok,
           %CosmarcaEstoque.Stocks.Products{
             id: 2,
             inserted_at: ~N[2019-04-21 21:03:47],
             name: "ClaryClean Amostra Gratis",
             updated_at: ~N[2019-04-21 21:03:47],
             user_id: 3
           }}

        assert expected == Find.find_by("ClaryClean Amostra Gratis")
      end
    end

    test "should get a simple product" do
      with_mock CosmarcaEstoque.Repo,
        get_by: fn _struct, _name -> nil end,
        all: fn _query -> skin_renov() end do
        assert nil ==
                 Repo.get_by(Products,
                   name: "Skin Renov - Creme Redutor de Estrias | Kit Trio - 3 Unidades"
                 )

        expected = %CosmarcaEstoque.Stocks.Products{
          id: 2,
          inserted_at: ~N[2019-04-21 21:03:47],
          name: "Skin Renov - Creme Redutor de Estrias",
          updated_at: ~N[2019-04-21 21:03:47],
          user_id: 3
        }

        assert [%{id: 2, name: "skin renov - creme redutor de estrias"}] == CosmarcaEstoque.Repo.all("query")


        {:ok, result} = Find.find_by("Skin Renov - Creme Redutor de Estrias | Kit Trio - 3 Unidades")
        assert "skin renov - creme redutor de estrias" == result.name

      end
    end
  end

  def skin_renov() do
    [
      %{"name": "skin renov - creme redutor de estrias", "id": 2}
    ]
  end

  def claryclean_amostra() do
    %CosmarcaEstoque.Stocks.Products{
      id: 2,
      inserted_at: ~N[2019-04-21 21:03:47],
      name: "ClaryClean Amostra Gratis",
      updated_at: ~N[2019-04-21 21:03:47],
      user_id: 3
    }
  end

  def claryclean() do
    %CosmarcaEstoque.Stocks.Products{
      id: 1,
      inserted_at: ~N[2019-04-21 21:03:47],
      name: "ClaryClean",
      updated_at: ~N[2019-04-21 21:03:47],
      user_id: 3
    }
  end
end
