defmodule CosmarcaEstoqueWeb.PageControllerTest do
  use CosmarcaEstoqueWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Total Revenue"
  end
end
