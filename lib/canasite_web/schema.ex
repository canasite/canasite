defmodule CanasiteWeb.Schema do
  @moduledoc """
  Graphql endpoints and type definition.
  """

  # import_types(__MODULE__.User.UserType)

  query do
    import_types(__MODULE__.User.UserQuery)
  end

  mutation do
    import_types(__MODULE__.User.UserMutation)
  end
end
