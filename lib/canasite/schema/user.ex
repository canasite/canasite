defmodule Canasite.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.ULID, autogenerate: true}

  schema "users" do
    field(:email, :string)
    field(:password, :string)
    field(:token, :string)

    timestamps()
  end

  @required_fields [:email, :password]
  @optional_fields [:token]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
