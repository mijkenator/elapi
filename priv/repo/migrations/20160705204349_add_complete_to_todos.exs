defmodule Elapi.Repo.Migrations.AddCompleteToTodos do
  use Ecto.Migration

  def change do
    alter table(:todos) do
      add :complete, :boolean, default: false
    end
  end
end
