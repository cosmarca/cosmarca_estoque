defmodule CosmarcaEstoqueWeb.ProductsController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Stocks
  alias CosmarcaEstoque.Stocks.Products

  # plug :verify_permission when action in [:update, :edit, :delete, :show]


  def index(conn, _params) do
    case conn.assigns.current_user.role == "admin" do
      true -> render(conn, "index.html", products: Stocks.list_products())
      false -> render(conn, "index.html", products: Stocks.list_products_by_user(conn.assigns.current_user.id))
    end
  end

  def new(conn, _params) do
    changeset = Stocks.change_products(%Products{})
    render(conn, "new.html", changeset: changeset, users: Stocks.user_for_select() )
  end

  def create(conn, %{"products" => products_params}) do
    case Stocks.create_products(products_params) do
      {:ok, products} ->
        conn
        |> put_flash(:info, "Produto #{products.name} criado!")
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
    |> put_flash(:info, "Produto #{products.name} deletado!.")
    |> redirect(to: Routes.products_path(conn, :index))
  end

  # def verify_permission(conn, params) do
  #   %{params: %{"id" => id}} = conn
  #   current_user = conn.assigns.current_user
    
  #   if Stocks.get_products!(id).user_id == current_user.id do
  #     conn
  #   else
  #     conn
  #     |> put_flash(:error, "Você não tem permissao para executar esta ação!")
  #     |> redirect(to: Routes.page_path(conn, :index))
  #     |> halt
  #   end
  # end
end
