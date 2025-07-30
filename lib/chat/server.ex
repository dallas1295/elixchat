defmodule Elixchat.Server do
  require Logger

  def start(port \\ 4040) do
    {:ok, listen_socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])

    Logger.info("Chat server started on port: #{port}")
    Logger.info("Waiting for connections...")

    accept_connections(listen_socket)
  end

  defp accept_connections(listen_socket) do
    {:ok, socket} = :gen_tcp.accept(listen_socket)
    Logger.info("New client connected")

    handle_client(socket)

    accept_connections(listen_socket)
  end

  defp handle_client(socket) do
    case recieve_message(socket) do
      :ok ->
        handle_client(socket)

      :closed ->
        Logger.info("\nClient disconnected")
        :gen_tcp.close(socket)
    end
  end

  defp recieve_message(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, message} ->
        IO.puts("Client: #{String.trim(message)}")
        response = "You: #{String.trim(message)}\n"
        :gen_tcp.send(socket, response)
        :ok

      {:error, :closed} ->
        :closed

      {:error, reason} ->
        Logger.error("Recieve error: #{reason}")
        :closed
    end
  end
end
