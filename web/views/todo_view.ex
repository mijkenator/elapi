defmodule Elapi.TodoView do
  use Elapi.Web, :view

  def render("index.json", %{todos: todos}) do
    %{data: render_many(todos, Elapi.TodoView, "todo.json")}
  end

  def render("show.json", %{todo: todo}) do
    %{data: render_one(todo, Elapi.TodoView, "todo.json")}
  end

  def render("todo.json", %{todo: todo}) do
    %{id: todo.id,
      description: todo.description}
  end
end
