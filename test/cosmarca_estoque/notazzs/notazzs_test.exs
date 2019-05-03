defmodule CosmarcaEstoque.NotazzsTest do
  use CosmarcaEstoque.DataCase

  alias CosmarcaEstoque.Notazzs

  describe "nota" do
    alias CosmarcaEstoque.Notazzs.Notazz

    @valid_attrs %{value: "some value"}
    @update_attrs %{value: "some updated value"}
    @invalid_attrs %{value: nil}

    def notazz_fixture(attrs \\ %{}) do
      {:ok, notazz} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Notazzs.create_notazz()

      notazz
    end

    test "list_nota/0 returns all nota" do
      notazz = notazz_fixture()
      assert Notazzs.list_nota() == [notazz]
    end

    test "get_notazz!/1 returns the notazz with given id" do
      notazz = notazz_fixture()
      assert Notazzs.get_notazz!(notazz.id) == notazz
    end

    test "create_notazz/1 with valid data creates a notazz" do
      assert {:ok, %Notazz{} = notazz} = Notazzs.create_notazz(@valid_attrs)
      assert notazz.value == "some value"
    end

    test "create_notazz/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Notazzs.create_notazz(@invalid_attrs)
    end

    test "update_notazz/2 with valid data updates the notazz" do
      notazz = notazz_fixture()
      assert {:ok, %Notazz{} = notazz} = Notazzs.update_notazz(notazz, @update_attrs)
      assert notazz.value == "some updated value"
    end

    test "update_notazz/2 with invalid data returns error changeset" do
      notazz = notazz_fixture()
      assert {:error, %Ecto.Changeset{}} = Notazzs.update_notazz(notazz, @invalid_attrs)
      assert notazz == Notazzs.get_notazz!(notazz.id)
    end

    test "delete_notazz/1 deletes the notazz" do
      notazz = notazz_fixture()
      assert {:ok, %Notazz{}} = Notazzs.delete_notazz(notazz)
      assert_raise Ecto.NoResultsError, fn -> Notazzs.get_notazz!(notazz.id) end
    end

    test "change_notazz/1 returns a notazz changeset" do
      notazz = notazz_fixture()
      assert %Ecto.Changeset{} = Notazzs.change_notazz(notazz)
    end
  end
end
