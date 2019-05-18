defmodule CanasiteWeb.Schema.User.Type do
  @moduledoc """
  Graphql Schema for user type.
  """
  use Absinthe.Schema.Notation
  alias CanasiteWeb.Schema.User.Resolver

  object :user do
    field(:id, non_null(:ulid))
    field(:email, non_null(:string))
    field(:password, non_null(:string))

    field(:token, non_null(:string)) do
      resolve(&Resolver.get_and_refresh_token/3)
    end
  end

  object :token do
    field(:token, non_null(:string))
  end
end
