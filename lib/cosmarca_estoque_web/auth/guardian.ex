defmodule CosmarcaEstoqueWeb.Auth.Guardian do
  alias CosmarcaEstoque.Accounts
  use Guardian, otp_app: :cosmarca_estoque

  def subject_for_token(%Accounts.User{} = user, _claims) do
    {:ok, to_string(user.id)}
  end

  def subject_for_token(_, _) do
      {:error, :reason_for_error}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user!(id) do
        nil -> {:error, :resource_not_found}
        user -> {:ok, user}
    end    
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

end
