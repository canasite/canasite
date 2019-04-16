defmodule Canasite.Schema.User do
  @moduledoc """
  User Schema.
  """

  alias Ecto.Changeset

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.ULID, autogenerate: true}
  @email_regex ~r/^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$/
  @required_fields [:email, :password]
  @error_email_format "Wrong email format"

  schema "users" do
    field(:email, :string)
    field(:password, :string)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_change(:email, &validate_email_format/2)
    |> password_hash()
  end

  defp password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp password_hash(changeset), do: changeset

  defp validate_email_format(:email, email) do
    if Regex.match?(@email_regex, email) do
      []
    else
      [email: @error_email_format]
    end
  end
end
