defmodule CanasiteWeb.User.MutationTest do
  @moduledoc false

  use CanasiteWeb.ConnCase, async: true

  @status_ok 200
  @bad_request 400
  @public_endpoint "/public/graphql"

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
        post(
          conn,
          @public_endpoint,
          query: @mutation,
          variables: %{email: "nathan@canasite.com", password: "yolo1234"}
        )

      assert json_response(conn, @status_ok) == %{
               "data" => %{"create_user" => %{"email" => "nathan@canasite.com"}}
             }
    end

    test "Without wrong email format", %{conn: conn} do
      conn =
        post(
          conn,
          @public_endpoint,
          query: @mutation,
          variables: %{email: "nathan.canasite.com", password: "yolo1234"}
        )

      assert json_response(conn, @status_ok) == %{
               "data" => %{"create_user" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 0, "line" => 2}],
                   "message" => %{"email" => ["Wrong email format"]},
                   "path" => ["create_user"],
                   "status" => @bad_request
                 }
               ]
             }
    end
  end
end
