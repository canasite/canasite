defmodule CanasiteWeb.Schema.User.Resolver do
  @moduledoc """
  Graphql User resolver module.
  """

  alias Canasite.Users
  alias Canasite.Schema.User

  def create_user(_root, args, _context) do
    with {:ok, %User{} = user} <- Users.create_user(args) do
      {:ok, user}
    else
      error -> {:error, error}
    end
  end
end
