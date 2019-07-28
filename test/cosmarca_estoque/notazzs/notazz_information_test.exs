defmodule CosmarcaEstoque.Stocks.Notazz.NotazzInformationTest do
  use CosmarcaEstoque.DataCase

  describe "should create nota in xml" do
    test "should read NF" do
      assert "" ==  CosmarcaEstoque.Notazzs.CreateNf.should_pick_det("/Users/gustavo/Development/repositories/github/smartdevbr/cosmarca_estoque/test/cosmarca_estoque/notazzs/nota.xml")
    end
  end
end
