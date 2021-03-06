defmodule CosmarcaEstoqueWeb.SessionController do
  use CosmarcaEstoqueWeb, :controller

  alias CosmarcaEstoque.{Accounts, Accounts.User, Accounts.Session}
  alias CosmarcaEstoqueWeb.Auth.Guardian

  def new(conn, _) do
    changeset = Accounts.change_user(%User{})

    if Guardian.Plug.current_resource(conn) do
      redirect(conn, to: Routes.page_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :login))
    end
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    Session.authentication(email, password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: Routes.session_path(conn, :login))
  end

  defp login_reply({:ok, user}, conn) do
    conn
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
