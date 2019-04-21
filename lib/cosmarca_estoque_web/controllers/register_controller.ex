defmodule CosmarcaEstoqueWeb.RegisterController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Stocks
  alias CosmarcaEstoque.Stocks.Register

  def index(conn, %{"products_id" => product_id}) do
    registers = Stocks.list_registers(product_id)
    render(conn, "index.html", registers: registers, product: product_id)
  end

  def new(conn, %{"products_id" => products_id}) do
    changeset = Stocks.change_register(%Register{})

    render(conn, "new.html",
      changeset: changeset,
      stock: products_id,
      products: Stocks.list_products_select()
    )
  end

  def create(conn, %{"products_id" => products_id, "register" => register_params}) do
    case Stocks.create_register(register_params, products_id, conn.assigns.current_user) do
      {:ok, register} ->
        conn
        |> put_flash(:info, "Registro criado com sucesso!")
        |> redirect(to: Routes.products_register_path(conn, :show, products_id, register))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, stock: products_id)
    end
  end

  def show(conn, %{"id" => id, "products_id" => products_id}) do
    register = Stocks.get_register!(id)
    render(conn, "show.html", stock: products_id, register: register)
  end

  def edit(conn, %{"id" => id, "products_id" => products_id}) do
    register = Stocks.get_register!(id)
    changeset = Stocks.change_register(register)

    render(conn, "edit.html",
      changeset: changeset,
      stock: products_id,
      register: register,
      products: Stocks.list_products_select()
    )
  end

  def update(conn, %{"products_id" => products_id, "register" => register_params, "id" => id}) do
    register = Stocks.get_register!(id)

    case Stocks.update_register(register, register_params) do
      {:ok, register} ->
        conn
        |> put_flash(:info, "Registro Atualizado com Sucesso!")
        |> redirect(to: Routes.products_register_path(conn, :show, products_id, register))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset, stock: products_id, register: register)
    end
  end

  def delete(conn, %{"products_id" => products_id, "id" => id}) do
    register = Stocks.get_register!(id)
    {:ok, _register} = Stocks.delete_register(register)

    conn
    |> put_flash(:info, "Register deleted successfully.")
    |> redirect(to: Routes.products_register_path(conn, :index, products_id))
  end
end
