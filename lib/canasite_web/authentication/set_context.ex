defmodule CanasiteWeb.Authentification.SetContext do
  @behavious Plug

  @moduledoc """
  Set current user
  """

  import Plug.Conn
  alias Absinthe.Plug

  def init(opts), do: opts

  def call(conn, _opts) do
    Plug.put_options(conn,
      context: %{
        current_user: Guardian.Plug.current_resource(conn)
      }
    )
  end
end
