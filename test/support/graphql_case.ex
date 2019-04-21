defmodule CanasiteWeb.Graphql do
  @moduledoc false
  use Phoenix.ConnTest
  @endpoint CanasiteWeb.Endpoint

  def graphql_query(conn, options) do
    conn
    |> post("/graphql", build_query(options[:query], options[:variables]))
  end

  defp build_query(query, variables) do
    %{
      "query" => query,
      "variables" => variables
    }
  end
end
