defmodule Canasite.Users do
  @moduledoc """
  Context that help for user manipulation.
  """
  use Ecto.Schema

  import Canasite.Repo

  alias Canasite.Schema.User
  alias Comeonin.Bcrypt

  def list_users do
    Repo.all(User)
  end

  def get_user!(id) do
    User
    |> Repo.get!(id)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.soft_delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def find_user_and_check_password(email, password) do
    User
    |> Repo.get_by(email: email)
    |> check_password(password)
  end

  defp check_password(%User{password: user_password}, password) do
    Bcrypt.checkpw(password, user_password)
  end

  defp check_password(_unvalide_user, _password), do: {:error, "invalid user"}
end
