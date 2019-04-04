defmodule CosmarcaEstoqueWeb.StockController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Stocks
  alias CosmarcaEstoque.Stocks.Stock

  def index(conn, _params) do
    stocks = Stocks.list_stocks()
    render(conn, "index.html", stocks: stocks)
  end

  def new(conn, _params) do
    users_without_stock = Stocks.users_without_stock()
    changeset = Stocks.change_stock(%Stock{})
    render(conn, "new.html", changeset: changeset, users: users_without_stock)
  end

  def create(conn, %{"stock" => stock_params}) do
    case Stocks.create_stock(stock_params) do
      {:ok, stock} ->
        conn
        |> put_flash(:info, "Stock created successfully.")
        |> redirect(to: Routes.stock_path(conn, :show, stock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stock = Stocks.get_stock!(id)
    render(conn, "show.html", stock: stock)
  end

  def edit(conn, %{"id" => id}) do
    stock = Stocks.get_stock!(id)
    changeset = Stocks.change_stock(stock)
    render(conn, "edit.html", stock: stock, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stock" => stock_params}) do
    stock = Stocks.get_stock!(id)

    case Stocks.update_stock(stock, stock_params) do
      {:ok, stock} ->
        conn
        |> put_flash(:info, "Stock updated successfully.")
        |> redirect(to: Routes.stock_path(conn, :show, stock))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stock: stock, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stock = Stocks.get_stock!(id)
    {:ok, _stock} = Stocks.delete_stock(stock)

    conn
    |> put_flash(:info, "Stock deleted successfully.")
    |> redirect(to: Routes.stock_path(conn, :index))
  end
end
