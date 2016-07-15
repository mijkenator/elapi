defmodule Elapi.Sess do
    def update(session, params) do
        changeset = Elapi.Session.changeset(session, 
                        %{data: Map.merge(session.data, params)})
        Elapi.Repo.update(changeset)       
    end
end
