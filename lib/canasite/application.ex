defmodule Canasite.Application do
  @moduledoc false

  use Application
  alias Canasite.Repo
  alias CanasiteWeb.Endpoint

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      Repo,
      Endpoint
    ]

    opts = [strategy: :one_for_one, name: Canasite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Endpoint.config_change(changed, removed)
    :ok
  end
end
