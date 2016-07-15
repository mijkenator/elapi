defmodule Elapi.Todo do
  use Elapi.Web, :model

  schema "todos" do
    field :description, :string
    field :complete, :boolean, default: false
    field :owner_id, :integer

    timestamps
  end

  @required_fields ~w(description complete owner_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
