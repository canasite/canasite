defmodule CanasiteWeb.Schema.User.Mutation do
  @moduledoc """
  Graphql User mutations.
  """

  use Absinthe.Schema.Notation

  alias CanasiteWeb.Schema.User

  object :user_mutations do
    @desc "Create a user"
    field(:create_user, type: :user) do
      @desc "Valide email address of the user."
      arg(:email, non_null(:string))
      @desc "Password of the user."
      arg(:password, non_null(:string))

      resolve(&User.Resolver.create/3)
    end
  end
end
