defmodule Elixchat do
  @moduledoc """
  Elixir Chat Application.
  """

  def start(_type, _args) do
    # This is called when starting as an OTP application
    {:ok, self()}
  end

  # Convenience functions for starting server/client
  def start_server(port \\ 4040) do
    Elixchat.Server.start(port)
  end

  def start_client(host \\ :localhost, port \\ 4040) do
    Elixchat.Client.start(host, port)
  end
end
