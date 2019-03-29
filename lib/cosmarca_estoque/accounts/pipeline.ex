defmodule CosmarcaEstoque.Accounts.Pipeline do
    use Guardian.Plug.Pipeline,
    otp_app: :cosmarca_estoque,
    error_handler: CosmarcaEstoqueWeb.ErrorHandler,
    module: CosmarcaEstoque.Accounts.Guardian

    plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
    # If there is an authorization header, restrict it to an access token and validate it
    plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
    # Load the user if either of the verifications worked
    plug Guardian.Plug.LoadResource, allow_blank: true
end