defmodule CanasiteWeb.Authentification.ErrorHandler do
  use CanasiteWeb, :controller

  @moduledoc """
  Handle error when there is a wrong token.
  """
  import Plug.Conn

  @behaviour Guardian.Plug.ErrorHandler
  @unauthorized "Not Authenticated"

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_status(:unauthorized)
    |> put_view(CanasiteWeb.ErrorView)
    |> render("error.json", message: @unauthorized)
  end
end
