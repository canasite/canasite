defmodule CanasiteWeb.PageController do
  use CanasiteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
