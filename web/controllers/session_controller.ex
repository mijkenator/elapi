defmodule Elapi.SessionController do
  require Logger
  use Elapi.Web, :controller

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias Elapi.User
  alias Elapi.Session

  def create(conn, up, _, _), do: create(conn, up)
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
        #Logger.debug("\n C2.1 #{inspect conn}")
        new_conn = Guardian.Plug.api_sign_in(conn, user)
        #Logger.debug("\n C2.2 #{inspect new_conn}")
        jwt    = Guardian.Plug.current_token(new_conn)
        Logger.debug("\n C2.3 #{inspect jwt}")
        {:ok, claims} = Guardian.Plug.claims(new_conn)
        Logger.debug("\n C2.4 #{inspect claims}")
        exp = Map.get(claims, "exp")
        Logger.debug("\n C2.5 #{inspect exp}")

        new_conn
        |> put_status(:created)
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> put_resp_header("x-expires", to_string(exp))
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

  def delete(conn, _,_,_)  do
        Guardian.Plug.sign_out(conn)
  end

end
