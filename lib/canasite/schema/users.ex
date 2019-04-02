defmodule Canasite.Users do
  use Ecto.Schema

  def list_users(filters \\ []) do
    User
    |> where(^filters)
    |> Repo.all()
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

  def delete_user(%Users{} = user) do
    Repo.soft_delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end
end
