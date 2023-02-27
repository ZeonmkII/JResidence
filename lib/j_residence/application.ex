defmodule JResidence.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    topologies = Application.get_env(:libcluster, :topologies) || []

    children = [
      # Start the Telemetry supervisor
      JResidenceWeb.Telemetry,
      # Start the Ecto repository
      JResidence.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: JResidence.PubSub},
      # Start Finch
      {Finch, name: JResidence.Finch},
      # Start the Endpoint (http/https)
      JResidenceWeb.Endpoint,
      # Start a worker by calling: JResidence.Worker.start_link(arg)
      # {JResidence.Worker, arg}
      # Start libCluster
      {Cluster.Supervisor, [topologies, [name: Dorm.ClusterSupervisor]]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JResidence.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    JResidenceWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
