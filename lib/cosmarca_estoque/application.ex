defmodule CosmarcaEstoque.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    import Supervisor.Spec, warn: false

    children = [
      # Start the Ecto repository
      CosmarcaEstoque.Repo,
      # Start the endpoint when the application starts
      CosmarcaEstoqueWeb.Endpoint,
      worker(CosmarcaEstoque.Scheduler, [])

      # Starts a worker by calling: CosmarcaEstoque.Worker.start_link(arg)
      # {CosmarcaEstoque.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CosmarcaEstoque.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CosmarcaEstoqueWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
