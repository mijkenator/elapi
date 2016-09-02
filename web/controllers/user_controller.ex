defmodule Elapi.UserController do
  use Elapi.Web, :controller
  require Logger

  alias Elapi.User

  plug :scrub_params, "user" when action in [:create]

  def create(conn, up, _, _), do: create(conn, up)
  def create(conn, %{"user" => user_params}) do
    Logger.debug "Elapi.UCC00"
    changeset = User.registration_changeset(%User{}, user_params)
    
    Logger.debug "Elapi.UCC0"

    case Repo.insert(changeset) do
      {:ok, user} ->
        Logger.debug "Elapi.UCC1"
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      {:error, changeset} ->
        Logger.debug "Elapi.UCC2"
        conn
        |> put_status(:unprocessable_entity)
        |> render(Elapi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def start_signup(conn, params, _, _), do: start_signup(conn, params)
  def start_signup(conn, _params) do

    render conn, "signup.html"
  end

end
