defmodule Brouteolli.Router do
  use Brouteolli.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Brouteolli do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    scope "/auth" do
      get "/login", AuthController, :index
      get "/logout", AuthController, :delete
      get "/callback", AuthController, :callback
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Brouteolli do
  #   pipe_through :api
  # end
end
