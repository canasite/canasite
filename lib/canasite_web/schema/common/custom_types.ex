defmodule CanasiteWeb.Schema.Common.CustomTypes do
  @moduledoc """
  Custom Absinthe type declarations and implementations
  """
  alias Ecto.ULID

  use Absinthe.Schema.Notation

  scalar :ulid, name: "ULID" do
    @desc "Scalar for ulid format."

    serialize(&serialize_ulid/1)
    parse(&parse_ulid/1)
  end

  defp parse_ulid(input_string), do: ULID.cast(input_string.value)
  defp serialize_ulid(ulid), do: ulid
end
