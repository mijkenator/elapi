ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Elapi.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Elapi.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Elapi.Repo)

