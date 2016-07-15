defmodule Elapi.Repo.Migrations.SessionData do
  use Ecto.Migration

  def change do
    alter table(:sessions) do
        add :data, :text
    end
  end
end
