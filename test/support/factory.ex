defmodule Canasite.Factory do
  @moduledoc """
  Make fake resources.
  """

  use ExMachina.Ecto, repo: Canasite.Repo

  # Schema factories
  def user_factory do
    %{
      email: sequence(:email, &"user#{&1}@mail.com"),
      password: sequence(:password, &"password#{&1}")
    }
  end
end
