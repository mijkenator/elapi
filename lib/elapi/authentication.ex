defimpl ExAdmin.Authentication, for: Plug.Conn do
    alias Elapi.Router.Helpers

    def use_authentication?(_), do: true
    def current_user(conn), do: Guardian.Plug.current_resource(conn)

    def current_user_name(conn) do 
        case Guardian.Plug.current_resource(conn) do
            nil  -> nil
            user -> user.name
        end
    end

    def session_path(conn, :destroy), do: Helpers.session_path(conn, :delete, 0)
    def session_path(conn, action), do: Helpers.session_path(conn, action)
end


defmodule Elapi.Authentication do
  def current_user(conn) do
    Guardian.Plug.current_resource(conn)
  end
end
