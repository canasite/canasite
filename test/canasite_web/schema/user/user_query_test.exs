defmodule CanasiteWeb.User.QueryTest do
  @moduledoc false

  use CanasiteWeb.ConnCase, async: true

  import Canasite.Factory

  alias CanasiteWeb.Schema.User.Resolver

  @endpoint_graphql "/graphql"
  @status_unauthorized 401
  @status_ok 200

  setup %{conn: conn} do
    {:ok, %{token: access_token} = user} = Resolver.create_user(nil, params_for(:user), nil)
    auth_conn = put_req_header(conn, "authorization", "Bearer #{access_token}")

    %{auth_conn: auth_conn, user: user, token: access_token}
  end

  @query """
  query {
    me {
      email
    }
  }
  """
  describe "Get user" do
    test "When no user is set", %{conn: conn} do
      conn = get(conn, @endpoint_graphql, query: @query)

      assert json_response(conn, @status_unauthorized) == %{"error" => "Not Authenticated"}
    end

    test "When we created our user before", %{auth_conn: auth_conn, user: %{email: email}} do
      conn = get(auth_conn, @endpoint_graphql, query: @query)

      assert json_response(conn, @status_ok) == %{
               "data" => %{"me" => %{"email" => email}}
             }
    end

    test "Try to change informations in token", %{conn: conn, token: token} do
      [header, payload, signature] = String.split(token, ".")
      IO.puts "\n==========\n\n"
      IO.inspect header
      IO.inspect payload
      IO.inspect signature
      IO.inspect Base.url_decode64(payload)
      IO.puts "\n\n==========\n"

    end
  end
end
