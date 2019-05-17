defmodule CanasiteWeb.Authentification.Guardian do
  @moduledoc """
  Guardian implementation.

  subject_for_token and resource_from_claims are inverses of one another.
  subject_for_token is used to encode the resource into the token,
  and resource_from_claims is used to rehydrate the resource from the claims.
  """
  use Guardian, otp_app: :canasite

  alias Canasite.Schema.{User, Users}

  @impl true
  def subject_for_token(%User{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  @impl true
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  @impl true
  def resource_from_claims(%{"sub" => user_id}) do
    with %User{} = user <- Users.get(user_id) do
      {:ok, user}
    else
      error -> {:error, error}
    end
  end

  @impl true
  def resource_from_claims(_claims) do
    {:error, :wrong_token}
  end
end
