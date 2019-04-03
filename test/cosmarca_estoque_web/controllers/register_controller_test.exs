defmodule CosmarcaEstoqueWeb.RegisterControllerTest do
  use CosmarcaEstoqueWeb.ConnCase

  alias CosmarcaEstoque.Stocks

  @create_attrs %{input_quantity: "some input_quantity", output_quantity: "some output_quantity"}
  @update_attrs %{input_quantity: "some updated input_quantity", output_quantity: "some updated output_quantity"}
  @invalid_attrs %{input_quantity: nil, output_quantity: nil}

  def fixture(:register) do
    {:ok, register} = Stocks.create_register(@create_attrs)
    register
  end

  describe "index" do
    test "lists all registers", %{conn: conn} do
      conn = get(conn, Routes.register_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Registers"
    end
  end

  describe "new register" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.register_path(conn, :new))
      assert html_response(conn, 200) =~ "New Register"
    end
  end

  describe "create register" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.register_path(conn, :create), register: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.register_path(conn, :show, id)

      conn = get(conn, Routes.register_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Register"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.register_path(conn, :create), register: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Register"
    end
  end

  describe "edit register" do
    setup [:create_register]

    test "renders form for editing chosen register", %{conn: conn, register: register} do
      conn = get(conn, Routes.register_path(conn, :edit, register))
      assert html_response(conn, 200) =~ "Edit Register"
    end
  end

  describe "update register" do
    setup [:create_register]

    test "redirects when data is valid", %{conn: conn, register: register} do
      conn = put(conn, Routes.register_path(conn, :update, register), register: @update_attrs)
      assert redirected_to(conn) == Routes.register_path(conn, :show, register)

      conn = get(conn, Routes.register_path(conn, :show, register))
      assert html_response(conn, 200) =~ "some updated input_quantity"
    end

    test "renders errors when data is invalid", %{conn: conn, register: register} do
      conn = put(conn, Routes.register_path(conn, :update, register), register: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Register"
    end
  end

  describe "delete register" do
    setup [:create_register]

    test "deletes chosen register", %{conn: conn, register: register} do
      conn = delete(conn, Routes.register_path(conn, :delete, register))
      assert redirected_to(conn) == Routes.register_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.register_path(conn, :show, register))
      end
    end
  end

  defp create_register(_) do
    register = fixture(:register)
    {:ok, register: register}
  end
end
