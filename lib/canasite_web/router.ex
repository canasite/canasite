defmodule CanasiteWeb.Router do
  use CanasiteWeb, :router

  pipeline :api do
    plug(CORSPlug, origin: "*")
    plug :accepts, ["json"]

    plug(
      Guardian.Plug.Pipeline,
      error_handler: CanasiteWeb.Authentification.ErrorHandler,
      module: CanasiteWeb.Authentification.Guardian
    )

    plug(Guardian.Plug.VerifyHeader, realm: "Bearer", claims: %{"typ" => "access"})
    plug(Guardian.Plug.LoadResource, allow_blank: true)
  end

  pipeline :restricted do
    plug Guardian.Plug.EnsureAuthenticated
    plug(Guardian.Plug.LoadResource)
    plug(CanasiteWeb.Authentification.SetContext)
  end

  scope "/" do
    pipe_through [:api, :restricted]

    post("/graphql", Absinthe.Plug, schema: CanasiteWeb.Schema)
  end

  scope "/public" do
    pipe_through :api

    post("/graphql", Absinthe.Plug, schema: CanasiteWeb.SchemaPublic)
  end
end
