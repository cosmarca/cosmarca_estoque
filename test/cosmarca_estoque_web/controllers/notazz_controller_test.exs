defmodule CosmarcaEstoqueWeb.NotazzControllerTest do
  use CosmarcaEstoqueWeb.ConnCase

  alias CosmarcaEstoque.Notazzs
  alias CosmarcaEstoque.Notazzs.Notazz

  @create_attrs %{
    value: "some value"
  }
  @update_attrs %{
    value: "some updated value"
  }
  @invalid_attrs %{value: nil}

  def fixture(:notazz) do
    {:ok, notazz} = Notazzs.create_notazz(@create_attrs)
    notazz
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all nota", %{conn: conn} do
      conn = get(conn, Routes.notazz_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create notazz" do
    test "renders notazz when data is valid", %{conn: conn} do
      conn = post(conn, Routes.notazz_path(conn, :create), notazz: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.notazz_path(conn, :show, id))

      assert %{
               "id" => id,
               "value" => "some value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.notazz_path(conn, :create), notazz: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update notazz" do
    setup [:create_notazz]

    test "renders notazz when data is valid", %{conn: conn, notazz: %Notazz{id: id} = notazz} do
      conn = put(conn, Routes.notazz_path(conn, :update, notazz), notazz: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.notazz_path(conn, :show, id))

      assert %{
               "id" => id,
               "value" => "some updated value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, notazz: notazz} do
      conn = put(conn, Routes.notazz_path(conn, :update, notazz), notazz: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete notazz" do
    setup [:create_notazz]

    test "deletes chosen notazz", %{conn: conn, notazz: notazz} do
      conn = delete(conn, Routes.notazz_path(conn, :delete, notazz))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.notazz_path(conn, :show, notazz))
      end
    end
  end

  defp create_notazz(_) do
    notazz = fixture(:notazz)
    {:ok, notazz: notazz}
  end
end
