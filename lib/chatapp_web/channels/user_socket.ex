defmodule ChatappWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "room:*", ChatappWeb.RoomChannel

  @impl true
  def connect(%{"user_id" => user_id}, socket, _connect_info) do
    {:ok, assign(socket, :user_id, user_id)}
  end

  @impl true
  def connect(_params, _socket, _connect_info) do
    :error
  end

  @impl true
  def id(socket) do
    case socket.assigns do
      %{user_id: user_id} -> "user_socket:#{user_id}"
      _ -> nil
    end
  end
end
