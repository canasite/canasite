defmodule CanasiteWeb.Schema.Common.ErrorResolver do
  @moduledoc """
  Error Helper
  """
  require Logger
  alias Ecto.Changeset

  @bad_request_status 400
  @bad_request "BAD REQUEST"

  # Error from changeset.
  def parse({:error, %Changeset{} = changeset}) do
    changeset
    |> Changeset.traverse_errors(fn {message, _} -> message end)
    |> parse(:bad_request, changeset)
  end

  # Format error for :bad_request
  def parse(message, :bad_request, error) do
    Logger.error("Bad request: #{inspect(error)}")
    render_error(message, @bad_request, @bad_request_status)
  end

  defp render_error(message, error_type, error_status),
    do: {:error, %{message: message, type: error_type, status: error_status}}
end
