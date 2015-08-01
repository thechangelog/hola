defmodule Hola.Router do
  use Hola.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Hola do
    pipe_through :api

    get "/", MemberController, :home
    post "/add", MemberController, :add
  end
end
