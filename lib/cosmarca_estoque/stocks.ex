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

  @doc """
  Gets a single products.

  Raises `Ecto.NoResultsError` if the Products does not exist.

  ## Examples

      iex> get_products!(123)
      %Products{}

      iex> get_products!(456)
      ** (Ecto.NoResultsError)

  """
  def get_products!(id), do: Repo.get!(Products, id)

  @doc """
  Creates a products.

  ## Examples

      iex> create_products(%{field: value})
      {:ok, %Products{}}

      iex> create_products(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_products(attrs \\ %{}) do
    %Products{}
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
  Returns the list of stocks.

  ## Examples

      iex> list_stocks()
      [%Stock{}, ...]

  """
  def list_stocks do
    Repo.all(Stock) |> Repo.preload(:user)
  end

  @doc """
  Gets a single stock.

  Raises `Ecto.NoResultsError` if the Stock does not exist.

  ## Examples

      iex> get_stock!(123)
      %Stock{}

      iex> get_stock!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stock!(id), do: Repo.get!(Stock, id) |> Repo.preload(:user)

  @doc """
  Creates a stock.

  ## Examples

      iex> create_stock(%{field: value})
      {:ok, %Stock{}}

      iex> create_stock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stock(attrs \\ %{}) do
    %{"user_stock" => user_id} = attrs
    user = CosmarcaEstoque.Accounts.get_user!(user_id)
    user
    |> Ecto.build_assoc(:stock)
    |> Stock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stock.

  ## Examples

      iex> update_stock(stock, %{field: new_value})
      {:ok, %Stock{}}

      iex> update_stock(stock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stock(%Stock{} = stock, attrs) do
    stock
    |> Stock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Stock.

  ## Examples

      iex> delete_stock(stock)
      {:ok, %Stock{}}

      iex> delete_stock(stock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stock(%Stock{} = stock) do
    Repo.delete(stock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stock changes.

  ## Examples

      iex> change_stock(stock)
      %Ecto.Changeset{source: %Stock{}}

  """
  def change_stock(%Stock{} = stock) do
    Stock.changeset(stock, %{})
  end
end
