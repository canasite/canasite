defmodule CanasiteWeb.Schema.User.Resolver do
  @moduledoc """
  Graphql User resolver module.
  """

  alias Canasite.Users
  alias Canasite.Schema.User
  alias CanasiteWeb.Schema.Common.ErrorResolver

  def create_user(_root, args, _context) do
    %{email: email, password: password} = args

    with {:ok, %User{} = user} <- Users.create_user(args) do
      {:ok, user}
    else
      error -> ErrorResolver.parse(error)
    end
  end

  def get_user(_root, _args, _context) do
    IO.puts("coucouc !!!!!!!!!!!!!!!!!!!!!")
  end
end
