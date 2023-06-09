defmodule GhIssueViewer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # GhIssueViewer.Repo, # don't need a DB, so commented this out
      # Start the Telemetry supervisor
      GhIssueViewerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GhIssueViewer.PubSub},
      # Start the Endpoint (http/https)
      GhIssueViewerWeb.Endpoint
      # Start a worker by calling: GhIssueViewer.Worker.start_link(arg)
      # {GhIssueViewer.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GhIssueViewer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GhIssueViewerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
