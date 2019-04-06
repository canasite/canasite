defmodule CanasiteWeb.Schema.User.Type do
  @moduledoc """
  Graphql Schema for user type.
  """
  use Absinthe.Schema.Notation

  object :user do
    field(:email, non_null(:string))
    field(:password, non_null(:string))
    field(:token, :string)
  end
end
