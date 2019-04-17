defmodule Canasite.Authentification.Guardian do
  @moduledoc """
  Guardian implementation.

  subject_for_token and resource_from_claims are inverses of one another.
  subject_for_token is used to encode the resource into the token,
  and resource_from_claims is used to rehydrate the resource from the claims.
  """
  use Guardian, otp_app: :canasite

  @impl true
  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  @impl true
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  @impl true
  def resource_from_claims(claims) do
    # Here we'll look up our resource from the claims, the subject can be
    # found in the `"sub"` key. In `above subject_for_token/2` we returned
    # the resource id so here we'll rely on that to look it up.
    id = claims["sub"]
    resource = MyApp.get_resource_by_id(id)
    {:ok, resource}
  end

  @impl true
  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
