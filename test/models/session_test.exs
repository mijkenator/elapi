defmodule Elapi.SessionTest do
  use Elapi.ModelCase

  alias Elapi.Session
  alias Elapi.User

  @valid_attrs %{user_id: "12345"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Session.changeset(%Session{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Session.changeset(%Session{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "create_changeset with valid attributes" do
    changeset = Session.create_changeset(%Session{}, @valid_attrs)
    assert changeset.changes.token
    assert changeset.valid?
  end

  test "create_changeset with invalid attributes" do
    changeset = Session.create_changeset(%Session{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "json field should work" do
    changeset = User.registration_changeset(%User{}, %{email: "bar@baz.com", password: "s3cr3t"})
    {:ok, user} = Elapi.Repo.insert(changeset) 
    
    assert is_integer(user.id) == true
    session = %Elapi.Session{
      user_id: user.id,
      data: %{
        pass_yards: 210
      }
    }
    {:ok, session} = Elapi.Repo.insert(session)

    sdata = Elapi.Session |> Elapi.Repo.get(session.id)
    assert sdata.data["pass_yards"] == 210
  end

end
