defmodule RealtimeChatWeb.RoomChannel do
  use RealtimeChatWeb, :channel

  alias RealtimeChatWeb.Presence

  @impl true
  def join("room:" <> room_id, payload, socket) do
    username = payload["username"] || "guest"

    user = %{
      id: "#{username}-#{System.unique_integer()}",
      username: username
    }

    socket =
      socket
      |> assign(:room_id, room_id)
      |> assign(:user, user)

    send(self(), :after_join)
    {:ok, socket}
  end

  @impl true
  def handle_info(:after_join, socket) do
    user = socket.assigns.user

    Presence.track(socket, user.id, %{
      username: user.username,
      online_at: System.system_time(:second)
    })

    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end

  @impl true
  def handle_in("new_msg", %{"body" => body}, socket) do
    %{user: user} = socket.assigns

    broadcast!(socket, "new_msg", %{
      user: user.username,
      body: body
    })

    {:noreply, socket}
  end
end
