defmodule Elapi.ChannelsDemoController do
  require Logger
  use Elapi.Web, :controller

  def channels_demo(conn, _params, current_user, _claims) do
    render conn, "channels_demo.html", current_user: current_user
  end

end

