defmodule CanasiteWeb.User.MutationTest do
  @moduledoc false

  use CanasiteWeb.ConnCase, async: true

  describe "Create user" do
    @mutation """
    mutation ($email: String!, $password: String!) {
      create_user(email: $email, password: $password) {
        email
      }
    }
    """
    test "With good params", %{conn: conn} do
      conn =
        post(conn, "/public/graphql",
          query: @mutation,
          variables: %{email: "nathan@canasite.com", password: "yolo1234"}
        )

      assert json_response(conn, 200) == %{
               "data" => %{"create_user" => %{"email" => "nathan@canasite.com"}}
             }
    end
  end
end
