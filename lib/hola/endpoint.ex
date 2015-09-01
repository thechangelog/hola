defmodule Hola.Endpoint do
  use Phoenix.Endpoint, otp_app: :hola

  plug Plug.RequestId
  plug Plug.Logger

  plug :force_json_content_type

  defp force_json_content_type(conn, _) do
    Plug.Conn.put_req_header(conn, "content-type", "application/json")
  end

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug :router, Hola.Router
end
