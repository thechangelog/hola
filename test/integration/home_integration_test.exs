defmodule HomeIntegrationTest do
  use ExUnit.Case

  alias Hola.Support.ApiCall

  setup_all do
    Hola.Support.Helpers.launch_api
  end

  test "GET to / redirects to changelog.com" do
    {_, response} = ApiCall.get "/"
    assert response.status_code == 302
    # I am 99% sure this is not the Elixir Way to do this ¯\_(ツ)_/¯
    {_, location} = Enum.find(response.headers, fn(x) -> elem(x, 0) == "location" end)
    assert location == "https://changelog.com"
  end
end
