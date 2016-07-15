defmodule Elapi.AuthenticationTest do
  use Elapi.ConnCase

  alias Elapi.{Authentication, Repo, User, Session}

  @opts Authentication.init([])

  def put_auth_token_in_header(conn, token) do
    conn
    |> put_req_header("authorization", "Token token=\"#{token}\"")
  end

  test "finds the user by token", %{conn: conn} do
    user = Repo.insert!(%User{email: "mkh@mkh.ru"})
    session = Repo.insert!(%Session{token: "123", user_id: user.id})

    conn = conn
    |> put_auth_token_in_header(session.token)
    |> Authentication.call(@opts)

    assert conn.assigns.current_user
  end

  test "invalid token", %{conn: conn} do
    conn = conn
    |> put_auth_token_in_header("foo")
    |> Authentication.call(@opts)

    assert conn.status == 200
    assert conn.resp_body == "{\"status\":\"failed\", \"errors\":[[0,\"authentication required\"]]}"
    assert conn.halted
  end

  test "no token", %{conn: conn} do
    conn = Authentication.call(conn, @opts)
    assert conn.status == 200
    assert conn.resp_body == "{\"status\":\"failed\", \"errors\":[[0,\"authentication required\"]]}"
    assert conn.halted
  end
end
