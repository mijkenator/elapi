defmodule Elapi.AuthController do
  use Elapi.Web, :controller
  require Logger

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  alias Elapi.User
  alias Elapi.Session
  alias Elapi.UserProperties

  def index(conn, _params, _current_user, _claims) do
    render conn, "index.html"
  end

  def login(conn, %{"identity" => "logout"}, _current_user, _claims) do
    Logger.debug("\n AUTH LOGOUT")
    Plug.CSRFProtection.delete_csrf_token()
    Guardian.Plug.sign_out(conn)
        |> put_flash(:info, "Logged out successfully")
        |> render("index.html")
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
        up = Repo.get_by(UserProperties, user_id: user.id)
        Logger.debug("LOGIN #{user.id} #{inspect up}")

        session_changeset = Session.create_changeset(%Session{}, %{user_id: user.id, data: sdata})
        {:ok, session} = Repo.insert(session_changeset)
        
        new_conn = cond do
            up && check_perm(up, "admin", "dashboard") ->
                Guardian.Plug.sign_in(conn, user, :token, perms: %{admin: [:dashboard]})
            up   -> Guardian.Plug.sign_in(conn, user, :token)
            true -> Guardian.Plug.sign_in(conn, user, :token)
        end

        jwt    = Guardian.Plug.current_token(new_conn)
        {:ok, claims} = Guardian.Plug.claims(new_conn)
        exp = Map.get(claims, "exp")

        new_conn
        |> put_flash(:info, "Authentication succeed")
        |> put_status(:created)
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> put_resp_header("x-expires", to_string(exp))
        #|> put_resp_cookie("_gjwt", jwt)
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
  
  def ddologout(conn, _params, _cu, _cl) do
    Logger.debug("\n AUTH LOGOUT")
    Plug.CSRFProtection.delete_csrf_token()
    #Plug.CSRFProtection.get_csrf_token()
    Guardian.Plug.sign_out(conn) 
        |> put_flash(:info, "Logged out successfully")
        |> render("index.html")
  end

  def check_perm(nil, _, _), do: false
  def check_perm(up, "admin", perm) do
    case up.data do
        %{"permissions" => %{"admin" => a_perm}} ->
             Logger.debug("Permissions: #{inspect a_perm}")
             Enum.member?(a_perm, perm)
        _ -> false
    end
  end

end

