defmodule CosmarcaEstoqueWeb.RegisterController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.Stocks
  alias CosmarcaEstoque.Stocks.Register

  def index(conn, %{"stock_id" => stock_id}) do
    
    registers = Stocks.list_registers()
    render(conn, "index.html", registers: registers, stock: stock_id)
  end

  def new(conn, _params) do
    changeset = Stocks.change_register(%Register{})
    IO.inspect "ooi"
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"register" => register_params}) do
    case Stocks.create_register(register_params) do
      {:ok, register} ->
        conn
        |> put_flash(:info, "Register created successfully.")
        |> redirect(to: Routes.stock_register_path(conn, :show, register))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    register = Stocks.get_register!(id)
    render(conn, "show.html", register: register)
  end

  def edit(conn, %{"id" => id}) do
    register = Stocks.get_register!(id)
    changeset = Stocks.change_register(register)
    render(conn, "edit.html", register: register, changeset: changeset)
  end

  def update(conn, %{"id" => id, "register" => register_params}) do
    register = Stocks.get_register!(id)

    case Stocks.update_register(register, register_params) do
      {:ok, register} ->
        conn
        |> put_flash(:info, "Register updated successfully.")
        |> redirect(to: Routes.stock_register_path(conn, :show, register))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", register: register, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    register = Stocks.get_register!(id)
    {:ok, _register} = Stocks.delete_register(register)

    conn
    |> put_flash(:info, "Register deleted successfully.")
    |> redirect(to: Routes.stock_register_path(conn, :index))
  end
end
