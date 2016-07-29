defmodule Elapi.AuthController do
  use Elapi.Web, :controller
  require Logger


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
    Logger.debug("\n AUTH LOGIN #{inspect conn}")
    render conn, "callback.html"
  end

  def ddologin(conn, _params, _cu, _cl) do
    Logger.debug("\n AUTH LOGIN #{inspect conn}")
    render conn, "callback.html"
  end

end

