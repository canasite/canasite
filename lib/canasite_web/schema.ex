defmodule CanasiteWeb.Schema do
  @moduledoc """
  Graphql endpoints and type definition.
  """
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(Absinthe.Plug.Types)
  import_types(__MODULE__.Common.CustomTypes)
  import_types(__MODULE__.User.UserType)
  import_types(__MODULE__.User.UserQuery)
  import_types(__MODULE__.User.UserMutation)

  query do
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:user_mutations)
  end
end
