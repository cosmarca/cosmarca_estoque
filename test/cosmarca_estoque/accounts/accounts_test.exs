defmodule CosmarcaEstoque.AccountsTest do
  use CosmarcaEstoque.DataCase

  alias CosmarcaEstoque.Accounts

  describe "users" do
    alias CosmarcaEstoque.Accounts.User

    @valid_attrs %{
      email: "some@email",
      first_name: "some first_name",
      last_name: "some last_name",
      password: "some password_hash",
      password_confirmation: "some password_hash"
    }
    @update_attrs %{
      email: "some@updatedemail",
      first_name: "some updated first_name",
      last_name: "some updated last_name",
      password: "some updated password_hash",
      password_confirmation: "some updated password_hash"
    }
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, password_hash: nil, role: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Enum.count(Accounts.list_users()) == Enum.count([user])
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id).id == user.id
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some@email"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.role == "user"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some@updatedemail"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.role == "user"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user.email == Accounts.get_user!(user.id).email
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
