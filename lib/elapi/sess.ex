defmodule Elapi.Sess do
    def update(session, params) do
        sdata = if session.data == nil, do: %{}, else: session.data
        changeset = Elapi.Session.changeset(session, 
                        %{data: Map.merge(sdata, params)})
        Elapi.Repo.update(changeset)       
    end
end
