defmodule CanasiteWeb.User.MutationTest do
  @moduledoc false

  use CanasiteWeb.ConnCase, async: true

  describe "Create user" do
    @mutation """
    mutation ($email: String!, $password: String!) {
      create_user(email: $email, password: $password) {
        id
        email
        password
        token
      }
    }
    """
    test "With good params", %{conn: conn} do
      conn =
        post(conn, "/graphql",
          query: @mutation,
          variables: %{email: "nathan@canasite.com", password: "yolo1234"})
      IO.puts "\n=========="
      IO.inspect conn

      assert json_response(conn, 200) == %{"data" => %{"user" => []}}
    end
  end
end
