defmodule Hola.Endpoint do
  use Phoenix.Endpoint, otp_app: :hola

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug :router, Hola.Router
end
