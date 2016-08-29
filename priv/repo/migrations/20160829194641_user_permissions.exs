defmodule Elapi.Repo.Migrations.UserPermissions do
  use Ecto.Migration

  def change do

    create table(:user_properties) do
      add :user_id, references(:users, on_delete: :nothing)
      add :data, :text

      timestamps
    end
    create index(:user_properties, [:user_id])

  end
end
