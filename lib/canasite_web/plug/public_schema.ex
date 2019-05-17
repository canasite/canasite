defmodule CanasiteWeb.Plug.SchemaPublic do
  @moduledoc """
  Allow us to use Absinthe.Plug multiple time in the router.
  """
  use Plug.Builder

  plug(Absinthe.Plug, schema: CanasiteWeb.SchemaPublic)
end
