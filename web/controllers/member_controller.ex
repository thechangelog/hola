defmodule Hola.MemberController do
  use Phoenix.Controller

  def add(conn, params) do
    event = params["event"]
    email = params["member"]["email"]

    if event == "member_signup" && email do
      Hola.Slack.invite(email)
      status = 200
      ok = true
    else
      status = 422
      ok = false
    end

    conn
    |> put_status(status)
    |> json %{ok: ok}
  end

  def home(conn, _params) do
    redirect conn, external: "https://changelog.com"
  end
end
