defmodule Tes.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TesWeb.Telemetry,
      # Start the Ecto repository
      Tes.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Tes.PubSub},
      # Start Finch
      {Finch, name: Tes.Finch},
      # Start the Endpoint (http/https)
      TesWeb.Endpoint
      # Start a worker by calling: Tes.Worker.start_link(arg)
      # {Tes.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Tes.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TesWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
