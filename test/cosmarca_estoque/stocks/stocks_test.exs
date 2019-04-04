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

  describe "stocks" do
    alias CosmarcaEstoque.Stocks.Stock

    @valid_attrs %{title: "some title"}
    @update_attrs %{title: "some updated title"}
    @invalid_attrs %{title: nil}

    def stock_fixture(attrs \\ %{}) do
      {:ok, stock} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stocks.create_stock()

      stock
    end

    test "list_stocks/0 returns all stocks" do
      stock = stock_fixture()
      assert Stocks.list_stocks() == [stock]
    end

    test "get_stock!/1 returns the stock with given id" do
      stock = stock_fixture()
      assert Stocks.get_stock!(stock.id) == stock
    end

    test "create_stock/1 with valid data creates a stock" do
      assert {:ok, %Stock{} = stock} = Stocks.create_stock(@valid_attrs)
      assert stock.title == "some title"
    end

    test "create_stock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stocks.create_stock(@invalid_attrs)
    end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{} = stock} = Stocks.update_stock(stock, @update_attrs)
      assert stock.title == "some updated title"
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = Stocks.update_stock(stock, @invalid_attrs)
      assert stock == Stocks.get_stock!(stock.id)
    end

    test "delete_stock/1 deletes the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{}} = Stocks.delete_stock(stock)
      assert_raise Ecto.NoResultsError, fn -> Stocks.get_stock!(stock.id) end
    end

    test "change_stock/1 returns a stock changeset" do
      stock = stock_fixture()
      assert %Ecto.Changeset{} = Stocks.change_stock(stock)
    end
  end

  describe "registers" do
    alias CosmarcaEstoque.Stocks.Register

    @valid_attrs %{input_quantity: "some input_quantity", output_quantity: "some output_quantity"}
    @update_attrs %{
      input_quantity: "some updated input_quantity",
      output_quantity: "some updated output_quantity"
    }
    @invalid_attrs %{input_quantity: nil, output_quantity: nil}

    def register_fixture(attrs \\ %{}) do
      {:ok, register} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stocks.create_register()

      register
    end

    test "list_registers/0 returns all registers" do
      register = register_fixture()
      assert Stocks.list_registers() == [register]
    end

    test "get_register!/1 returns the register with given id" do
      register = register_fixture()
      assert Stocks.get_register!(register.id) == register
    end

    test "create_register/1 with valid data creates a register" do
      assert {:ok, %Register{} = register} = Stocks.create_register(@valid_attrs)
      assert register.input_quantity == "some input_quantity"
      assert register.output_quantity == "some output_quantity"
    end

    test "create_register/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stocks.create_register(@invalid_attrs)
    end

    test "update_register/2 with valid data updates the register" do
      register = register_fixture()
      assert {:ok, %Register{} = register} = Stocks.update_register(register, @update_attrs)
      assert register.input_quantity == "some updated input_quantity"
      assert register.output_quantity == "some updated output_quantity"
    end

    test "update_register/2 with invalid data returns error changeset" do
      register = register_fixture()
      assert {:error, %Ecto.Changeset{}} = Stocks.update_register(register, @invalid_attrs)
      assert register == Stocks.get_register!(register.id)
    end

    test "delete_register/1 deletes the register" do
      register = register_fixture()
      assert {:ok, %Register{}} = Stocks.delete_register(register)
      assert_raise Ecto.NoResultsError, fn -> Stocks.get_register!(register.id) end
    end

    test "change_register/1 returns a register changeset" do
      register = register_fixture()
      assert %Ecto.Changeset{} = Stocks.change_register(register)
    end
  end
end
