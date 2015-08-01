defmodule Hola.Router do
  use Hola.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Hola do
    pipe_through :api

    get "/", ApiController, :home
    post "/memberful", ApiController, :memberful
  end
end
