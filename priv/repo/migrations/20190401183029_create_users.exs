defmodule Canasite.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add(:id, :binary_id, null: false, primary_key: true)
      add(:email, :string)
      add(:password, :string)

      timestamps()
    end

    create(unique_index(:users, :email))
  end
end
