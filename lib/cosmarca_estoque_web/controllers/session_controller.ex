defmodule CosmarcaEstoqueWeb.SessionController do
    use CosmarcaEstoqueWeb, :controller

    alias CosmarcaEstoque.{Accounts, Accounts.User, Accounts.Guardian, Accounts.Session}

    def new(conn, _) do
        changeset = Accounts.change_user(%User{})
        maybe_user = Guardian.Plug.current_resource(conn)
        if maybe_user do
          redirect(conn, to: "/secret")
        else
          render(conn, "new.html", changeset: changeset, action: Routes.session_path(conn, :login))
        end
      end

    def login(conn, %{"user" => %{"email" => email, "password" => password }}) do
        Session.authentication(email, password)
        |> login_reply(conn)
    end

    def logout(conn, _) do
        conn
        |> configure_session(drop: true)
        |> Guardian.Plug.sign_out()
        |> redirect(to: "/login")
    end

    defp login_reply({:ok, user}, conn) do
        conn
        |> put_flash(:sucess, "Bem vindo! #{user.first_name}")
        |> put_session(:user_id, user.id)
        |> Guardian.Plug.sign_in(user)
        |> redirect(to: Routes.page_path(conn, :secret))
    end

    defp login_reply({:error, reason}, conn) do
        conn
        |> put_flash(:error, to_string(reason))
        |> new(%{})
    end
end 