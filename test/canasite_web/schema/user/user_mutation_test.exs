defmodule CanasiteWeb.User.MutationTest do
  @moduledoc false

  use CanasiteWeb.ConnCase, async: true

  describe "Create user" do
    @mutation """
    mutation {
      create_user {
        id
      }
    }
    """
    test "With good params" do
      conn = get(conn, "/graphql", query: @query)
      assert json_response(conn, 200) == %{"data" => %{"user" => []}}
    end
  end
end
