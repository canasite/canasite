defmodule CanasiteWeb.User.QueryTest do
  @moduledoc false

  use CanasiteWeb.ConnCase, async: true
  use CanasiteWeb.AuthCase

  @endpoint_graphql "/graphql"
  @status_unauthorized 401
  @status_ok 200

  @query """
  query {
    me {
      email
    }
  }
  """
  describe "Get user" do
    test "When no user is set", %{conn: conn} do
      assert conn
             |> get(@endpoint_graphql, query: @query)
             |> json_response(@status_unauthorized) == %{"error" => "Not Authenticated"}
    end

    test "When we created our user before", %{auth_conn: auth_conn, user: %{email: email}} do
      assert auth_conn
             |> get(@endpoint_graphql, query: @query)
             |> json_response(@status_ok) == %{
               "data" => %{"me" => %{"email" => email}}
             }
    end

    test "Try to change informations in token", %{conn: conn, token: token} do
      [header, payload, signature] = String.split(token, ".")
      {:ok, decoded_payload} = Base.decode64(payload, padding: false)

      hacked_payload =
        decoded_payload
        |> String.replace("Canasite", "Hack")
        |> Base.encode64(padding: false)

      assert conn
             |> put_req_header("authorization", "Bearer #{header}.#{hacked_payload}.#{signature}")
             |> get(@endpoint_graphql, query: @query)
             |> json_response(@status_unauthorized)
    end
  end
end
