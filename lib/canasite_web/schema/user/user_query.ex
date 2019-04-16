defmodule CanasiteWeb.Schema.User.Query do
  @moduledoc """
  Graphql User queries.
  """
  use Absinthe.Schema.Notation

  alias CanasiteWeb.Schema.User.Resolver

  object :user_queries do
    @desc "Fetch userfull informations about user profil."
    field :me, :user do
      @desc "Valide access token."
      arg(:token, non_null(:string))

      resolve(&Resolver.get_user/3)
    end
  end
end
