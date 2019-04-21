defmodule CosmarcaEstoque.Stocks do
  @moduledoc """
  The Stocks context.
  """

  import Ecto.Query, warn: false

  alias CosmarcaEstoque.Repo

  alias CosmarcaEstoque.Stocks.Products

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Products{}, ...]

  """
  def list_products do
    Repo.all(Products)
  end

  def list_products_by_user(user_id) do
    Enum.filter(Repo.all(Products) |> Repo.preload(:register), &(&1.user_id == user_id))
  end

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      {{"beauty cream", 1}, ...]

  """
  def list_products_select do
    Repo.all(from p in "products", select: {p.name, p.id})
  end

  @doc """
  Gets a single products.

  Raises `Ecto.NoResultsError` if the Products does not exist.

  ## Examples

      iex> get_products!(123)
      %Products{}

      iex> get_products!(456)
      ** (Ecto.NoResultsError)

  """
  def get_products!(id), do: Repo.get!(Products, id) |> Repo.preload(:user)

  @doc """
  Creates a products.

  ## Examples

      iex> create_products(%{field: value})
      {:ok, %Products{}}

      iex> create_products(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_products(attrs \\ %{}) do
    %{"user_owner" => user_id} = attrs
    user = CosmarcaEstoque.Accounts.get_user!(user_id)

    user
    |> Ecto.build_assoc(:products)
    |> Products.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a products.

  ## Examples

      iex> update_products(products, %{field: new_value})
      {:ok, %Products{}}

      iex> update_products(products, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_products(%Products{} = products, attrs) do
    products
    |> Products.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Products.

  ## Examples

      iex> delete_products(products)
      {:ok, %Products{}}

      iex> delete_products(products)
      {:error, %Ecto.Changeset{}}

  """
  def delete_products(%Products{} = products) do
    Repo.delete(products)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking products changes.

  ## Examples

      iex> change_products(products)
      %Ecto.Changeset{source: %Products{}}

  """
  def change_products(%Products{} = products) do
    Products.changeset(products, %{})
  end

  alias CosmarcaEstoque.Stocks.Stock

  @doc """
    Returns the list of users without stock.

    ## Examples

        iex> users_without_stock()
        [{"admin", "id"}, ...]

  """
  def user_for_select do
    Repo.all(from u in "users", select: {u.first_name, u.id})
    # stock = Repo.all(from s in "stocks", select: s.user_id)
    # Enum.map(users, fn {x, id} ->
    #   if Enum.filter(stock, &(&1 == id)) |> Enum.count() == 0 do
    #     {x, id}
    #   end
    # end)
  end

  alias CosmarcaEstoque.Stocks.Register

  @doc """
  Returns the list of registers.

  ## Examples

      iex> list_registers(product_id)
      [%Register{}, ...]

  """
  def list_registers(product_id) do
    product = get_products!(product_id) |> Repo.preload(register: [:user])
    product.register
  end

  @doc """
  Returns the list of registers.

  ## Examples

      iex> list_registers(user_id)
      [%Register{}, ...]

  """
  def list_registers_from_user(user_id) do
    stock =
      Repo.all(from s in "stocks", where: s.user_id == ^user_id)
      |> Repo.preload(register: [:products, :user])

    stock.register
  end

  @doc """
  Gets a single register.

  Raises `Ecto.NoResultsError` if the Register does not exist.

  ## Examples

      iex> get_register!(123)
      %Register{}

      iex> get_register!(456)
      ** (Ecto.NoResultsError)

  """
  def get_register!(id), do: Repo.get!(Register, id) |> Repo.preload([:products, :user])

  @doc """
  Creates a register.

  ## Examples

      iex> create_register(%{field: value})
      {:ok, %Register{}}

      iex> create_register(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_register(attrs \\ %{}, products_id, user) do
    get_products!(products_id)
    |> Ecto.build_assoc(:register,
      products_id: products_id,
      user_id: user.id
    )
    |> Register.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a register.

  ## Examples

      iex> update_register(register, %{field: new_value})
      {:ok, %Register{}}

      iex> update_register(register, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_register(%Register{} = register, attrs) do
    register
    |> Register.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Register.

  ## Examples

      iex> delete_register(register)
      {:ok, %Register{}}

      iex> delete_register(register)
      {:error, %Ecto.Changeset{}}

  """
  def delete_register(%Register{} = register) do
    Repo.delete(register)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking register changes.

  ## Examples

      iex> change_register(register)
      %Ecto.Changeset{source: %Register{}}

  """
  def change_register(%Register{} = register) do
    Register.changeset(register, %{})
  end
end
