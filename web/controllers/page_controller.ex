defmodule Elapi.PageController do
  use Elapi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
