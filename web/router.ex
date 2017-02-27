defmodule Phello.Router do
  use Phello.Web, :router

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

  scope "/", Phello do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/boards", BoardController do
      resources "/cards", CardController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", Phello do
  #   pipe_through :api
  # end
end
