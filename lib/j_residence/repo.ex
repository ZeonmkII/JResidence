defmodule JResidence.Repo do
  use Ecto.Repo,
    otp_app: :j_residence,
    adapter: Ecto.Adapters.Postgres
end
