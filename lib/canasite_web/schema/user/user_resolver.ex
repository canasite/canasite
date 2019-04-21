defmodule CanasiteWeb.Schema.User.Resolver do
  @moduledoc """
  Graphql User resolver module.
  """

  alias Canasite.Authentification.Guardian
  alias Canasite.Schema.User
  alias Canasite.Users
  alias CanasiteWeb.Schema.Common.ErrorResolver

  @doc """
  Create user with `email` and `password`.
  It will save the user in the DB and generate a `token`.
  """
  def create_user(_root, args, _context) do
    # Check parameters.
    %{email: _email, password: _password} = args

    with {:ok, %User{} = user} <- Users.create_user(args),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user, %{}, ttl: {2, :weeks}) do
      result =
        user
        |> Map.from_struct()
        |> Map.merge(%{token: token})

      {:ok, result}
    else
      error -> ErrorResolver.parse(error)
    end
  end

  def get_user(_root, args, _context) do
    IO.puts("\n==========\n\n")
    IO.inspect(args)
    IO.puts("\n\n==========\n")
  end
end
