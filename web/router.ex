defmodule Elapi.Router do
  use Elapi.Web, :router
  use ExAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :br_lgn_required do
    plug Guardian.Plug.EnsureAuthenticated, handler: Elapi.PageController
    plug Guardian.Plug.EnsurePermissions, handler: Elapi.PageController, admin: [:dashboard]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", Elapi do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/channels", ChannelsDemoController, :channels_demo
    get "/signup", UserController, :start_signup
  end

  # Other scopes may use custom stacks.
   scope "/api", Elapi do
     pipe_through [:api, :api_auth]

     resources "/todos", TodoController, except: [:new, :edit]
     resources "/users", UserController, only: [:create]
     resources "/sessions", SessionController, only: [:create, :delete]
     get "rs_se", TodoController, :rs_se
     get "rs_sp", TodoController, :rs_sp
   end

   scope "/admin", ExAdmin do
     pipe_through [:browser, :browser_session, :br_lgn_required]
     admin_routes
   end

  scope "/auth", Elapi do
    pipe_through [:browser] # Use the default browser stack

    get "/:identity", AuthController, :login
    get "/:identity/callback", AuthController, :callback
    post "/:identity/callback", AuthController, :callback

    post "/login", AuthController, :ddologin
    get "/logout", AuthController, :ddologout

  end
end
