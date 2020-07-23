defmodule RandomCat.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      RandomCatWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RandomCat.PubSub},
      # Start the Endpoint (http/https)
      RandomCatWeb.Endpoint
      # Start a worker by calling: RandomCat.Worker.start_link(arg)
      # {RandomCat.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RandomCat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RandomCatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
