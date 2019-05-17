defmodule Canasite.Schema.Users do
  @moduledoc """
  Context that help for user manipulation.
  """
  use EctoCrux, module: Canasite.Schema.User

  alias Canasite.Repo
  alias Canasite.Schema.User

  def user_authenticate(email, password) do
    User
    |> Repo.get_by(email: email)
    |> check_password(password)
  end

  defp check_password(%User{password: user_password}, password) do
    Bcrypt.check_pass(password, user_password)
  end

  defp check_password(_unvalide_user, _password), do: {:error, "invalid user"}
end
