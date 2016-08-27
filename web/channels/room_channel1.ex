defmodule Elapi.RoomChannel1 do
  use Phoenix.Channel
  import Guardian.Phoenix.Socket
  require Logger

  @doc """
  Authorize socket to subscribe and broadcast events on this channel & topic

  Possible Return Values

  `{:ok, socket}` to authorize subscription for channel for requested topic

  `:ignore` to deny subscription/broadcast on this channel
  for the requested topic
  """
  def join("rooms:lobby", %{"token" => token} = message, socket) do
    Logger.debug("RCH1:join by token: #{token}")
    Logger.debug("RCH1:join:room:lobby #{inspect message} #{inspect socket}")

    case sign_in(socket, token) do
        {:ok, authed_socket, guardian_params} ->
            Logger.debug("RCH1:join AUTH #{inspect guardian_params}")
            Process.flag(:trap_exit, true)
            :timer.send_interval(5000, :ping)
            #send(self, {:after_join, message})
            send(self, {:after_join, Map.merge(message, %{"user" =>  guardian_params.resource.email}) })
            {:ok, authed_socket}
        {:error, reason} -> {:error, %{reason: reason}}
    end
  end
  def join("rooms:lobby", message, socket) do
    Logger.debug("RCH1:join:room:lobby #{inspect message} not-auth")
    Process.flag(:trap_exit, true)
    :timer.send_interval(5000, :ping)
    send(self, {:after_join, message})
    {:ok, socket}
  end

  def join("rooms:" <> private_subtopic, message, _socket) do
    Logger.debug("RCH1:rooms #{inspect private_subtopic} #{inspect message}")
    {:error, %{reason: "unauthorized"}}
  end

  def handle_info({:after_join, msg}, socket) do
    Logger.debug("RCH1:HIAJ #{inspect msg}")
    broadcast! socket, "user:entered", %{user: msg["user"]}
    push socket, "join", %{status: "connected"}
    {:noreply, socket}
  end
  def handle_info(:ping, socket) do
    Logger.debug("RCH1:HIPING")
    push socket, "new:msg", %{user: "SYSTEM", body: "ping"}
    {:noreply, socket}
  end

  def terminate(reason, _socket) do
    Logger.debug"> leave #{inspect reason}"
    :ok
  end

  def handle_in("new:msg", msg, socket) do
    Logger.debug("RCH1:HIN NM #{inspect msg}")
    broadcast! socket, "new:msg", %{user: msg["user"], body: msg["body"]}
    {:reply, {:ok, %{msg: msg["body"]}}, assign(socket, :user, msg["user"])}
  end
end

