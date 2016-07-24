defmodule Elapi.Authentication do
  require Logger

  import Plug.Conn
  alias Elapi.{Repo, User, Session}
  import Ecto.Query, only: [from: 2]

  def init(options), do: options
  
  def call(%Plug.Conn{body_params: %{"token" => token}} = conn, _opts) do
    try do
        case token
            |> find_session_by_token()
            |> find_user_by_session() do
              {:ok, user, session} -> 
                    conn |> assign(:current_user, user) |> assign(:mkh_sess, session)
              _otherwise  ->
                Logger.debug "Elapi.Auth call otherwise error3"
                auth_error!(conn)
        end
    catch
        _,_ ->
            Logger.debug "Elapi.Auth auth error2"
            auth_error!(conn)
    end
  end
  def call(conn, _opts) do
    Logger.debug "Elapi.Auth Call!"
    try do
        case find_user(conn) do
          {:ok, user, session} -> 
                conn 
                    |> assign(:current_user, user) 
                    |> assign(:mkh_sess, session)
          _otherwise  ->
            Logger.debug "Elapi.Auth call otherwise error"
            auth_error!(conn)
        end
    catch
        CE,CR  ->
            Logger.debug "Elapi.Auth auth error1 #{inspect CE} #{inspect CR}"
            auth_error!(conn)
    end
  end

  defp find_user(conn) do
    Logger.debug "Elapi.Auth find_user"
    try do
        #with auth_header = get_req_header(conn, "authorization"),
        #     {:ok, token}   <- parse_token(conn, auth_header),
        #     {:ok, session} <- find_session_by_token(token),
        #do:  find_user_by_session(session)
        auth_header = get_req_header(conn, "authorization")
        case parse_token(conn, auth_header) do
            {:ok, token} ->
                {:ok, session} = find_session_by_token(token)
                find_user_by_session(session)
            {:ok, user, nil} -> #case of JWT authorization
                {:ok, user, nil}
        end
    rescue
        _ ->
            Logger.debug "Elapi find_user error"
            auth_error!(conn)
    end
  end

  defp parse_token(_, ["Token token=" <> token]) do
    Logger.debug "Elapi.Auth parse token"
    {:ok, String.replace(token, "\"", "")}
  end
  defp parse_token(conn, ["Bearer " <> token]) do
    Logger.debug "JWT: #{token}"
    user = Guardian.Plug.current_resource(conn)
    Logger.debug "JWT user: #{inspect user}"
    {:ok, user, nil}
  end
  defp parse_token(_, _non_token_header) do
    Logger.debug "Elapi.Auth parse token: non_token_header"
    :error
  end

  defp find_session_by_token(token) do
    case Repo.one(from s in Session, 
                    where: s.token == ^token, 
                    where: s.updated_at >= datetime_add(^Ecto.DateTime.utc,-1,"day") ) do
      nil     -> :error
      session -> {:ok, session}
    end
  end

  defp find_user_by_session({:ok, session}),  do: find_user_by_session(session)
  defp find_user_by_session(session) do
    case Repo.get(User, session.user_id) do
      nil  -> :error
      user -> {:ok, user, session}
    end
  end

  defp auth_error!(conn) do
    Logger.debug "Elapi.a_e!"
    conn |> put_status(:unauthorized) 
         |> send_resp(200, '{"status":"failed", "errors":[[0,"authentication required"]]}') 
         |> halt()
  end
end

