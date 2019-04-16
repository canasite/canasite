defmodule CanasiteWeb.Router do
  use CanasiteWeb, :router

  pipeline :api do
    plug :accepts, ["json"]

    # plug(Guardian.Plug.Pipeline,
    #   module: CanasiteWeb.Guardian
    # )
    # plug(Guardian.Plug.VerifyHeader, realm: "Token")
    # plug(Guardian.Plug.LoadResource, allow_blank: true)
  end

  scope "/" do
    pipe_through :api

    forward("/graphql", Absinthe.Plug, schema: CanasiteWeb.Schema)
  end

  scope "/public" do
    pipe_through :api

    post("/graphql", Absinthe.Plug, schema: CanasiteWeb.SchemaPublic)
  end
end
