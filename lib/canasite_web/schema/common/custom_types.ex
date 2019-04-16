defmodule CanasiteWeb.Schema.Common.CustomTypes do
  @moduledoc """
  Custom Absinthe type declarations and implementations
  """
  alias Ecto.ULID

  use Absinthe.Schema.Notation

  scalar :ulid do
    description("Scalar for ulid format.")

    serialize(&encode/1)
    parse(&decode/1)
  end

  defp decode(%{value: value}), do: ULID.cast(value)
  defp encode(ulid), do: ulid
end
