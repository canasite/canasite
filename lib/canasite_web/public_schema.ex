defmodule CanasiteWeb.PublicSchema do
  @moduledoc """
  Graphql endpoints and type definition for public endpoints.
  """
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(Absinthe.Plug.Types)
  import_types(CanasiteWeb.Schema.User.Type)
  import_types(CanasiteWeb.Schema.User.Mutation)

  query do
  end

  mutation do
    import_fields(:user_public_mutations)
  end
end
