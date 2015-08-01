defmodule Hola.Slack do
  use HTTPoison.Base

  def process_url(url) do
    "https://changelog-members.slack.com/api/" <> url
  end

  def process_response_body(body) do
    try do
      Poison.decode!(body, keys: :atoms!)
    rescue
      _ -> body
    end
  end

  def process_request_headers(headers) do
    [{"content-type", "application/x-www-form-urlencoded"} | headers]
  end

  def invite(email) do
    token = System.get_env("SLACK_API_TOKEN")
    form = ~s(email=#{email}&token=#{token}&set_active=true)
    response = post "/users.admin.invite", form
    elem(response, 1).body.ok
  end
end
