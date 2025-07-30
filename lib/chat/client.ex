defmodule Elixchat.Client do
  require Logger

  def start(host \\ ~c"localhost", port \\ 4040) do
    case :gen_tcp.connect(host, port, [:binary, packet: :line, active: false]) do
      {:ok, socket} ->
        Logger.info("Connected to server")
        chat_loop(socket)

      {:error, reason} ->
        Logger.error("Failed to connect to server: #{reason}")
    end
  end

  defp chat_loop(socket) do
    spawn(fn -> receive_messages(socket) end)

    send_messages(socket)
  end

  defp receive_messages(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, message} ->
        IO.puts("Anon: #{String.trim(message)}")
        receive_messages(socket)

      {:error, _} ->
        IO.puts("Connection closed")
    end
  end

  defp send_messages(socket) do
    input = IO.gets("Type your messages: ")
    message = String.trim(input) <> "\n"

    case(:gen_tcp.send(socket, message)) do
      :ok -> send_messages(socket)
      {:error, _} -> :ok
    end
  end
end
