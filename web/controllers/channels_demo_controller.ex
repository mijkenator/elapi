defmodule Elapi.ChannelsDemoController do
  require Logger
  use Elapi.Web, :controller

  plug Guardian.Plug.VerifySession
  plug :put_layout, "channel.html"

  def channels_demo(conn, _params, current_user, _claims) do
    render conn, "channels_demo.html", current_user: current_user
  end

end

