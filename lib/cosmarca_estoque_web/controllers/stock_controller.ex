defmodule CosmarcaEstoqueWeb.StockController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Stocks
  alias CosmarcaEstoque.Stocks.Stock
  import Ecto.Query, only: [from: 2]

  def index(conn, _params) do
    stocks = Stocks.list_stocks()
    render(conn, "index.html", stocks: stocks)
  end

  def new(conn, _params) do
    # users_with_stock = CosmarcaEstoque.Repo.all from u in "stocks", select: u.user_id
    users_select = CosmarcaEstoque.Repo.all from u in "users", select: {u.first_name, u.id}
    stock = CosmarcaEstoque.Repo.all from s in "stocks", select: s.user_id
    users = Enum.map users_select, fn {x, id} -> 
       if Enum.count(Enum.filter(stock, fn x -> x == id end)) == 0 do 
        {x, id}  
       end 
    end
    changeset = 
    Stocks.change_stock(%Stock{})
    render(conn, "new.html", changeset: changeset, users: users )
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
    users_select = CosmarcaEstoque.Repo.all from u in "users", select: {u.first_name, u.id} 

    stock = Stocks.get_stock!(id)
    changeset = Stocks.change_stock(stock)
    render(conn, "edit.html", stock: stock, changeset: changeset, users: users_select)
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
