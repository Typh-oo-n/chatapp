defmodule ChatappWeb.RoomChannel do
  use ChatappWeb, :channel
  alias Chatapp.Chat
  alias ChatappWeb.Presence


  @impl true
  def join("room:lobby", payload, socket) do
    if authorized?(payload) do
      # Track user presence
      user_id = socket.assigns.user_id
      Presence.track(self(), "room:lobby", user_id, %{})

      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_in("new_message", %{"content" => content}, socket) do
    user_id = socket.assigns.user_id
    case Chat.create_message(%{content: content, user_id: user_id}) do
      {:ok, message} ->
        broadcast(socket, "new_message", %{"content" => content, "user_id" => user_id})
        {:noreply, socket}
      _ ->
        {:reply, {:error, "Unable to send message"}, socket}
    end
  end

  @impl true
  def handle_info({:presence_diff, diff}, socket) do
    broadcast(socket, "presence_diff", diff)
    {:noreply, socket}
  end

  @impl true
  def terminate(_reason, socket) do
    user_id = socket.assigns.user_id
    Presence.untrack(self(), "room:lobby", user_id)
    :ok
  end

  defp authorized?(_payload) do
    true
  end
end
