defmodule CanasiteWeb.Schema.User.Mutation do
  @moduledoc """
  Graphql User mutations.
  """

  use Absinthe.Schema.Notation

  alias CanasiteWeb.Schema.User.Resolver

  @desc "Mutation when token is required."
  object :user_mutations do
  end

  @desc "Mutation without token."
  object :user_public_mutations do
    @desc "Create a user."
    field :create_user, :user do
      @desc "Valide email address of the user."
      arg(:email, non_null(:string))
      @desc "Password of the user."
      arg(:password, non_null(:string))

      resolve(&Resolver.create_user/3)
    end
  end
end
