defmodule Elapi.UserView do
  use Elapi.Web, :view

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Elapi.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email}
  end
end
