defmodule Canasite.Repo do
  use Ecto.Repo,
    otp_app: :canasite,
    adapter: Ecto.Adapters.Postgres
end
