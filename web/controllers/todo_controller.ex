defmodule Elapi.TodoController do
  use Elapi.Web, :controller
  require Logger

  alias Elapi.Todo

  plug :scrub_params, "todo" when action in [:create, :update]

  plug Elapi.Authentication

  def index(conn,  params, _,_), do: index(conn, params)
  def index(conn, _params) do
    user_id = conn.assigns.current_user.id
    session = conn.assigns.mkh_sess
    query = from t in Todo, where: t.owner_id == ^user_id
    todos = Repo.all(query)
    case session do
        nil ->
            Logger.debug("UID: #{user_id} JWT AUTH no session")
        _   ->
            Logger.debug("UID: #{user_id} SID:#{session.id} SDATA:#{inspect session.data}")
            Elapi.Sess.update(session, %{param1: "kuku"})
    end
    render(conn, "index.json", todos: todos)
  end

  def create(conn, up, _, _), do: create(conn, up)
  def create(conn, %{"todo" => todo_params}) do
    changeset = Todo.changeset(
      %Todo{owner_id: conn.assigns.current_user.id}, todo_params
    )

    case Repo.insert(changeset) do
      {:ok, todo} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", todo_path(conn, :show, todo))
        |> render("show.json", todo: todo)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Elapi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, up, _, _), do: show(conn, up)
  def show(conn, %{"id" => id}) do
    todo = Repo.get!(Todo, id)
    render(conn, "show.json", todo: todo)
  end

  def update(conn, up, _, _), do: update(conn, up)
  def update(conn, %{"id" => id, "todo" => todo_params}) do
    todo = Repo.get!(Todo, id)
    changeset = Todo.changeset(todo, todo_params)

    case Repo.update(changeset) do
      {:ok, todo} ->
        render(conn, "show.json", todo: todo)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Elapi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, up, _, _), do: delete(conn, up)
  def delete(conn, %{"id" => id}) do
    todo = Repo.get!(Todo, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(todo)

    send_resp(conn, :no_content, "")
  end

  def rs_se(conn, _,_,_) do
    querystring = "select count(*) from users"
    {:ok, result} = Ecto.Adapters.SQL.query(Repo, querystring , [])
    Logger.debug "EAS ret: #{inspect result}"
    acc = Map.get(result, :rows) |> List.first()
    conn
    |> render("any.json", resp: %{"type" => "rs_se", "status" => "ok", "acc" => acc})
  end
  def rs_sp(conn, _,_,_) do

    send_resp(conn, :no_content, "")
  end

end

