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
    plug CosmarcaEstoqueWeb.Auth.Pipeline
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :user_admin do
    plug :ensure_auth
    plug CosmarcaEstoqueWeb.Auth.CheckAdmin
  end

  # everyone can see
  scope "/", CosmarcaEstoqueWeb do
    pipe_through :browser
    get "/login", SessionController, :new
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
  end

  # just authenticated can see
  scope "/", CosmarcaEstoqueWeb do
    pipe_through [:browser, :ensure_auth]
    resources "/users", UserController, only: [:show, :edit, :update, :new]
    get "/", PageController, :index
  end

  # just authenticated can see
  scope "/", CosmarcaEstoqueWeb do
    pipe_through [:browser, :user_admin]
    resources "/users", UserController
    resources "/products", ProductsController do
      resources "/registers", RegisterController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", CosmarcaEstoqueWeb do
  #   pipe_through :api
  # end
end
