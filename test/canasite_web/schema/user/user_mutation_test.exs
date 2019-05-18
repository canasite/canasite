defmodule CanasiteWeb.User.MutationTest do
  @moduledoc false

  use CanasiteWeb.ConnCase, async: true
  use CanasiteWeb.AuthCase

  @status_ok 200
  @bad_request_status 400
  @bad_request "BAD REQUEST"
  @public_endpoint "/public/graphql"
  # @endpoint_graphql "/graphql"

  describe "Create user" do
    @mutation """
    mutation ($email: String!, $password: String!) {
      create_user(email: $email, password: $password) {
        email
      }
    }
    """
    test "With good params", %{conn: conn} do
      assert conn
             |> post(@public_endpoint,
               query: @mutation,
               variables: %{email: "nathan@canasite.com", password: "yolo1234"}
             )
             |> json_response(@status_ok) == %{
               "data" => %{"create_user" => %{"email" => "nathan@canasite.com"}}
             }
    end

    test "Without wrong email format", %{conn: conn} do
      assert conn
             |> post(
               @public_endpoint,
               query: @mutation,
               variables: %{email: "nathan.canasite.com", password: "yolo1234"}
             )
             |> json_response(@status_ok) == %{
               "data" => %{"create_user" => nil},
               "errors" => [
                 %{
                   "locations" => [%{"column" => 0, "line" => 2}],
                   "message" => %{"email" => ["Wrong email format"]},
                   "path" => ["create_user"],
                   "status" => @bad_request_status,
                   "type" => @bad_request
                 }
               ]
             }
    end
  end

  describe "Refresh token" do
    @mutation """
    mutation ($email: String!, $password: String!) {
      refresh_token(email: $email, password: $password) {
        token
      }
    }
    """
    test "With good params", %{conn: conn, token: _token, user: user} do
      %{email: email, password: password} = user

      response =
        conn
        |> post(
          @public_endpoint,
          query: @mutation,
          variables: %{email: email, password: password}
        )
        |> json_response(@status_ok)

      assert match?(
               %{
                 "data" => %{
                   "refresh_token" => %{
                     "token" => _token
                   }
                 }
               },
               response
             ) && bit_size(response["data"]["refresh_token"]["token"]) > 0
    end
  end
end
