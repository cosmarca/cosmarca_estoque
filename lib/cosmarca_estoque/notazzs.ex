defmodule CosmarcaEstoque.Notazzs do
  @moduledoc """
  The Notazzs context.
  """

  import Ecto.Query, warn: false
  alias CosmarcaEstoque.Repo

  alias CosmarcaEstoque.Notazzs.Notazz

  @doc """
  Returns the list of nota.

  ## Examples

      iex> list_nota()
      [%Notazz{}, ...]

  """
  def list_nota do
    Repo.all(Notazz)
  end

  @doc """
  Gets a single notazz.

  Raises `Ecto.NoResultsError` if the Notazz does not exist.

  ## Examples

      iex> get_notazz!(123)
      %Notazz{}

      iex> get_notazz!(456)
      ** (Ecto.NoResultsError)

  """
  def get_notazz!(id), do: Repo.get!(Notazz, id)

  @doc """
  Creates a notazz.

  ## Examples

      iex> create_notazz(%{field: value})
      {:ok, %Notazz{}}

      iex> create_notazz(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_notazz(attrs \\ %{}) do
    %Notazz{}
    |> Notazz.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a notazz.

  ## Examples

      iex> update_notazz(notazz, %{field: new_value})
      {:ok, %Notazz{}}

      iex> update_notazz(notazz, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_notazz(%Notazz{} = notazz, attrs) do
    notazz
    |> Notazz.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Notazz.

  ## Examples

      iex> delete_notazz(notazz)
      {:ok, %Notazz{}}

      iex> delete_notazz(notazz)
      {:error, %Ecto.Changeset{}}

  """
  def delete_notazz(%Notazz{} = notazz) do
    Repo.delete(notazz)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking notazz changes.

  ## Examples

      iex> change_notazz(notazz)
      %Ecto.Changeset{source: %Notazz{}}

  """
  def change_notazz(%Notazz{} = notazz) do
    Notazz.changeset(notazz, %{})
  end
end
