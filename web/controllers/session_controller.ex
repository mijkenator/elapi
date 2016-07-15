defmodule Elapi.SessionController do
  use Elapi.Web, :controller

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias Elapi.User
  alias Elapi.Session

  def create(conn, %{"user" => user_params}) do
    user = Repo.get_by(User, email: user_params["email"])
    cond do
      user && checkpw(user_params["password"], user.password_hash) ->
        sdata = %{
            ip: Enum.join(Tuple.to_list(conn.remote_ip), "."),
            test: "lalalal"
        }
        session_changeset = Session.create_changeset(%Session{}, %{user_id: user.id, data: sdata})
        {:ok, session} = Repo.insert(session_changeset)
        conn
        |> put_status(:created)
        |> render("show.json", session: session)
      user ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", user_params)
      true ->
        dummy_checkpw
        conn
        |> put_status(:unauthorized)
        |> render("error.json", user_params)
    end
  end
end
