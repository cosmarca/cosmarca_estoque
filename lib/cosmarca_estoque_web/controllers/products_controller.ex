defmodule CosmarcaEstoqueWeb.ProductsController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Stocks
  alias CosmarcaEstoque.Stocks.Products

  def index(conn, _params) do
    products = Stocks.list_products()
    render(conn, "index.html", products: products)
  end

  def new(conn, _params) do
    changeset = Stocks.change_products(%Products{})
    render(conn, "new.html", changeset: changeset, users: Stocks.user_for_select() )
  end

  def create(conn, %{"products" => products_params}) do
    case Stocks.create_products(products_params) do
      {:ok, products} ->
        conn
        |> put_flash(:info, "Products created successfully.")
        |> redirect(to: Routes.products_path(conn, :show, products))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    products = Stocks.get_products!(id)
    render(conn, "show.html", products: products)
  end

  def edit(conn, %{"id" => id}) do
    products = Stocks.get_products!(id)
    changeset = Stocks.change_products(products)
    render(conn, "edit.html", products: products, changeset: changeset)
  end

  def update(conn, %{"id" => id, "products" => products_params}) do
    products = Stocks.get_products!(id)

    case Stocks.update_products(products, products_params) do
      {:ok, products} ->
        conn
        |> put_flash(:info, "Products updated successfully.")
        |> redirect(to: Routes.products_path(conn, :show, products))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", products: products, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    products = Stocks.get_products!(id)
    {:ok, _products} = Stocks.delete_products(products)

    conn
    |> put_flash(:info, "Products deleted successfully.")
    |> redirect(to: Routes.products_path(conn, :index))
  end
end
