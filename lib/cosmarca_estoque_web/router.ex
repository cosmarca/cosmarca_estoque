defmodule CosmarcaEstoqueWeb.Router do
  use CosmarcaEstoqueWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :auth do
    plug CosmarcaEstoque.Accounts.Pipeline
  end

  scope "/", CosmarcaEstoqueWeb do
    pipe_through :browser

    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
  end

  scope "/", CosmarcaEstoqueWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    get "/secret", PageController, :secret
    resources "/users", UserController
    get "/", PageController, :index


  end

  # Other scopes may use custom stacks.
  # scope "/api", CosmarcaEstoqueWeb do
  #   pipe_through :api
  # end
end
