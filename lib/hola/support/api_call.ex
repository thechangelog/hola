defmodule Hola.Support.ApiCall do
  use HTTPoison.Base

  def process_url(url) do
    api_url <> url
  end

  def process_response_body(body) do
    try do
      Poison.decode!(body, keys: :atoms!)
    rescue
      _ -> body
    end
  end

  def process_request_body(body) do
    Poison.encode!(body)
  end

  def process_request_headers(headers) do
    [{"content-type", "application/json"} | headers]
  end

  # API url helper - will work in any env
  defp api_url do
    endpoint_config = Application.get_env(:hola, Hola.Endpoint)
    host = Keyword.get(endpoint_config, :url) |> Keyword.get(:host)
    port = Keyword.get(endpoint_config, :http) |> Keyword.get(:port)

    "http://#{host}:#{port}/"
  end
end
