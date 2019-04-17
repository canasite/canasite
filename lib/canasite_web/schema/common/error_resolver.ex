defmodule CanasiteWeb.Schema.Common.ErrorResolver do
  @moduledoc """
  Error Helper
  """
  alias Ecto.Changeset
  @bad_request 400

  def parse({:error, %Changeset{} = changeset}) do
    changeset
    |> Changeset.traverse_errors(fn {message, _} -> message end)
    |> error_message(@bad_request)
  end

  defp error_message(message, status), do: {:error, %{status: status, message: message}}
end
