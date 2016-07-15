defmodule Elapi.Json do
  defmodule Type do
    @behaviour Ecto.Type
    alias Elapi.Json
 
    def type, do: :json

    def load({:ok, json}), do: {:ok, json}
    def load(value), do: load(Poison.decode(value))
    
    def dump(value), do: Poison.encode(value)

    def cast(value) when is_map(value), do: {:ok, value}
    def cast(_), do: :error
    
  end
end
