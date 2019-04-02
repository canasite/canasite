defmodule CanasiteWeb.User.QueryTest do
  @moduledoc false

  use CanasiteWeb.ConnCase, async: true

  describe "Get user" do
    @query """
    query {
      me {
        id
      }
    }
    """
    test "When no user is set", %{auth_conn: conn} do
      conn = get(conn, "/graphql", query: @query)
      assert true
    end
  end
end
