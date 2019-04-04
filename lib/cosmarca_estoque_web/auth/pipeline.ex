defmodule CosmarcaEstoqueWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :cosmarca_estoque,
    error_handler: CosmarcaEstoqueWeb.Auth.GuardianErrorHandler,
    module: CosmarcaEstoqueWeb.Auth.Guardian

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
  plug CosmarcaEstoqueWeb.Auth.CurrentUser
  plug Guardian.Plug.EnsureAuthenticated
end
