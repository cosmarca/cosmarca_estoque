defmodule CosmarcaEstoque.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string, unique: true
    field :first_name, :string
    field :last_name, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :key_notazz, :string
    field :cnpj, :string
    field :business_name, :string
    field :fancy_name, :string
    field :role, :string, default: "user"

    has_many :products, CosmarcaEstoque.Stocks.Products
    has_many :register, CosmarcaEstoque.Stocks.Register
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :email,
      :first_name,
      :last_name,
      :password,
      :password_confirmation,
      :key_notazz,
      :cnpj,
      :business_name,
      :fancy_name,
      :role
    ])
    |> validate_required(
      [
        :email,
        :first_name,
        :last_name,
        :password,
        :password_confirmation,
        :cnpj,
        :business_name,
        :fancy_name,
        :role
      ],
      message: "Você deve preencher este campo"
    )
    |> validate_format(:email, ~r/@/, message: "Formato de email inválido")
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 100, message: "Deve ter entre 6 a 100 carácteres")
    |> validate_confirmation(:password, message: "Não são iguais ")
    |> unique_constraint(:email, message: "Já existe usuário com este email")
    |> hash_password
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end

  defp hash_password(changeset) do
    changeset
  end
end
