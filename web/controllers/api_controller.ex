defmodule Hola.ApiController do
  use Phoenix.Controller

  def home(conn, _params) do
    redirect conn, external: "https://changelog.com"
  end

  def memberful(conn, params) do
    event = params["event"]
    email = params["member"]["email"]

    if event == "member_signup" && email do
      result = Hola.Slack.invite(email)

      if !result.ok do
        message = result.error
      end

      ok = true
    else
      ok = false
      message = "Unsupported Event"
    end

    conn
    |> put_status(200)
    |> json %{ok: ok, message: message}
  end
end
