defmodule Elapi.Session do
  use Elapi.Web, :model

  schema "sessions" do
    field :token, :string
    belongs_to :user, Elapi.User
    field :data, Elapi.Json.Type

    timestamps
  end

  @required_fields ~w(user_id)
  @optional_fields ~w(data)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def create_changeset(model, params \\ :empty) do
    model
    |> changeset(params)
    |> put_change(:token, SecureRandom.urlsafe_base64())
  end

end
