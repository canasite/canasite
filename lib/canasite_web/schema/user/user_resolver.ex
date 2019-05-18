defmodule CanasiteWeb.Schema.User.Resolver do
  @moduledoc """
  Graphql User resolver module.
  """
  require Logger

  alias Canasite.Schema.{User, Users}
  alias CanasiteWeb.Authentification.Guardian
  alias CanasiteWeb.Schema.Common.ErrorResolver

  @doc """
  Create user with `email` and `password`.
  It will save the user in the DB and generate a `token`.
  """
  def create_user(_root, args, _context) do
    # Check parameters.
    Logger.info("Create User Resolver")
    %{email: _email, password: _password} = args

    with {:ok, %User{} = user} <- Users.create(args),
         {:ok, token, _claims} <- generate_token(user) do
      result =
        user
        |> Map.from_struct()
        |> Map.merge(%{token: token})

      {:ok, result}
    else
      error -> ErrorResolver.parse(error)
    end
  end

  @doc """
  Get user using only the token found in the header
  """
  def get_user(_root, _args, context) do
    Logger.info("Get User Resolver")
    %{context: %{current_user: user}} = context

    {:ok, user}
  end

  @doc """
  Refresh the token using passord and login
  """
  def refresh_token(_root, %{email: email, password: password}, _context) do
    Logger.info("Refresh Token Resolver")

    with {:ok, %User{} = user} <- Users.user_authenticate(email, password),
         {:ok, token, _claims} <- generate_token(user) do
      {:ok, %{token: token}}
    else
      error -> ErrorResolver.parse(error)
    end
  end

  defp generate_token(%User{} = user) do
    Guardian.encode_and_sign(user, %{}, ttl: {2, :weeks})
  end
end
