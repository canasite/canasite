defmodule CanasiteWeb.AuthCase do
  @moduledoc """
  This module defines functions to authenticate user during test.
  """
  use ExUnit.CaseTemplate

  import Canasite.Factory

  alias CanasiteWeb.Schema.User.Resolver
  alias Phoenix.ConnTest
  alias Plug.Conn

  setup _ do
    user = params_for(:user)
    {:ok, %{token: access_token}} = Resolver.create_user(nil, user, nil)

    auth_conn =
      ConnTest.build_conn()
      |> Conn.put_req_header("authorization", "Bearer #{access_token}")

    {:ok, auth_conn: auth_conn, user: user, token: access_token}
  end
end
