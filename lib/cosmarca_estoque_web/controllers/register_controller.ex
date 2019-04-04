defmodule CosmarcaEstoqueWeb.RegisterController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Stocks
  alias CosmarcaEstoque.Stocks.Register

  def index(conn, %{"stock_id" => stock_id}) do
    registers = Stocks.list_registers(stock_id)
    render(conn, "index.html", registers: registers, stock: stock_id)
  end

  def new(conn, %{"stock_id" => stock_id}) do
    changeset = Stocks.change_register(%Register{})

    render(conn, "new.html",
      changeset: changeset,
      stock: stock_id,
      products: Stocks.list_products_select()
    )
  end

  def create(conn, %{"stock_id" => stock_id,  "register" => register_params}) do
    case Stocks.create_register(register_params, stock_id, conn.assigns.current_user) do
      {:ok, register} ->
        conn
        |> put_flash(:info, "Register created successfully.")
        |> redirect(
          to:
            Routes.stock_register_path(conn, :show, stock_id, register)
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, stock: stock_id)
    end
  end

  def show(conn, %{"id" => id, "stock_id" => stock_id}) do
    IO.inspect "oooi"
    register = Stocks.get_register!(id)
    render(conn, "show.html", stock: stock_id, register: register)
  end

  def edit(conn, %{"id" => id, "stock_id" => stock_id}) do
    register = Stocks.get_register!(id)
    changeset = Stocks.change_register(register)

    render(conn, "edit.html",
      changeset: changeset,
      stock: stock_id,
      register: register,
      products: Stocks.list_products_select()
    )
  end

  def update(conn, %{"stock_id" => stock_id, "register" => register_params, "id" => id}) do
    register = Stocks.get_register!(id)

    case Stocks.update_register(register, register_params) do
      {:ok, register} ->
        conn
        |> put_flash(:info, "Register updated successfully.")
        |> redirect(
          to: Routes.stock_register_path(conn, :show, stock_id, register)
        )

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset, stock: stock_id, register: register)
    end
  end

  def delete(conn, %{ "stock_id" => stock_id, "id" => id}) do
    register = Stocks.get_register!(id)
    {:ok, _register} = Stocks.delete_register(register)

    conn
    |> put_flash(:info, "Register deleted successfully.")
    |> redirect(to: Routes.stock_register_path(conn, :index, stock_id))
  end
end
