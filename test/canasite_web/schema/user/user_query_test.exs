defmodule CanasiteWeb.User.QueryTest do
  @moduledoc false

  use CanasiteWeb.ConnCase, async: true
  import CanasiteWeb.Graphql

  @unauthorized 401

  describe "Get user" do
    @query """
    query ($token: String!) {
      me(token: $token) {
        email
      }
    }
    """
    test "When no user is set", %{conn: conn} do
      conn = graphql_query(conn, %{query: @query, variables: %{token: "123"}})

      assert json_response(conn, @unauthorized) == %{"error" => "Not Authenticated"}
    end
  end
end
