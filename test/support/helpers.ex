defmodule Hola.Support.Helpers do
  def launch_api do
    # set up config for serving
    endpoint_config =
      Application.get_env(:hola, Hola.Endpoint)
      |> Keyword.put(:server, true)
    :ok = Application.put_env(:hola, Hola.Endpoint, endpoint_config)

    # restart our application with serving enabled
    :ok = Application.stop(:hola)
    :ok = Application.start(:hola)
  end
end
