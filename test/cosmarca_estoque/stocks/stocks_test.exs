defmodule CosmarcaEstoque.StocksTest do
  use CosmarcaEstoque.DataCase

  alias CosmarcaEstoque.Stocks

  describe "products" do
    alias CosmarcaEstoque.Stocks.Products

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def products_fixture(attrs \\ %{}) do
      {:ok, products} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stocks.create_products()

      products
    end

    test "list_products/0 returns all products" do
      products = products_fixture()
      assert Stocks.list_products() == [products]
    end

    test "get_products!/1 returns the products with given id" do
      products = products_fixture()
      assert Stocks.get_products!(products.id) == products
    end

    test "create_products/1 with valid data creates a products" do
      assert {:ok, %Products{} = products} = Stocks.create_products(@valid_attrs)
      assert products.name == "some name"
    end

    test "create_products/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stocks.create_products(@invalid_attrs)
    end

    test "update_products/2 with valid data updates the products" do
      products = products_fixture()
      assert {:ok, %Products{} = products} = Stocks.update_products(products, @update_attrs)
      assert products.name == "some updated name"
    end

    test "update_products/2 with invalid data returns error changeset" do
      products = products_fixture()
      assert {:error, %Ecto.Changeset{}} = Stocks.update_products(products, @invalid_attrs)
      assert products == Stocks.get_products!(products.id)
    end

    test "delete_products/1 deletes the products" do
      products = products_fixture()
      assert {:ok, %Products{}} = Stocks.delete_products(products)
      assert_raise Ecto.NoResultsError, fn -> Stocks.get_products!(products.id) end
    end

    test "change_products/1 returns a products changeset" do
      products = products_fixture()
      assert %Ecto.Changeset{} = Stocks.change_products(products)
    end
  end
end
