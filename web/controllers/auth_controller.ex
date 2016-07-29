defmodule Elapi.AuthController do
  use Elapi.Web, :controller
  require Logger

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias Elapi.User
  alias Elapi.Session

  def index(conn, _params, _current_user, _claims) do
    render conn, "index.html"
  end

  def login(conn, _params, _current_user, _claims) do
    render conn, "index.html"
  end

  def callback(conn, _params, _current_user, _claims) do
    Logger.debug("\n AUTH CALLBACK #{inspect conn}")
    render conn, "callback.html"
   # conn
   #     |> put_flash(:info, "Success AUTH")
   #     |> render("callback.html") 
    #   |> redirect(to: "/")
  end

  def ddologin(conn, _params) do
    Logger.debug("\n AUTH LOGIN1 #{inspect conn}")
    render conn, "callback.html"
  end

  def ddologin(conn, %{"username" => email, "password" => password} = _params, _cu, _cl) do
    user = Repo.get_by(User, email: email)
    cond do
      user && checkpw(password, user.password_hash) ->
        sdata = %{
            ip: Enum.join(Tuple.to_list(conn.remote_ip), "."),
            test: "lalalal"
        }
        session_changeset = Session.create_changeset(%Session{}, %{user_id: user.id, data: sdata})
        {:ok, session} = Repo.insert(session_changeset)
        new_conn = Guardian.Plug.sign_in(conn, user)
        jwt    = Guardian.Plug.current_token(new_conn)
        {:ok, claims} = Guardian.Plug.claims(new_conn)
        exp = Map.get(claims, "exp")

        new_conn
        |> put_flash(:info, "Authentication succeed")
        |> put_status(:created)
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> put_resp_header("x-expires", to_string(exp))
        |> render("callback.html", session: session)

      user ->
        conn
        |> put_flash(:error, "Authentication failed")
        |> put_status(:unauthorized)
        |> render("index.html")
      true ->
        dummy_checkpw
        conn
        |> put_flash(:error, "Authentication failed")
        |> put_status(:unauthorized)
        |> render("index.html")
    end
  end

end

