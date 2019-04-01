defmodule CanasiteWeb.Schema.User.UserType do
  @moduledoc """
  Graphql Schema for user type.
  """
  use Absinthe.Schema.Notation

  object :user do
    field(:id, non_null(:ulid))
    field(:email, non_null(:string))
    field(:password, non_null(:string))
    field(:token, non_null(:string))
  end
end
