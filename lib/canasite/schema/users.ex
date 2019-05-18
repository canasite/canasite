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

  defp check_password(%User{password: password_hash} = user, password) do
    with {:ok, %{password_hash: _hash}} <-
           Bcrypt.check_pass(%{password_hash: password_hash}, password) do
      {:ok, user}
    else
      error -> error
    end
  end

  defp check_password(_unvalide_user, _password), do: {:error, "invalid user"}
end
