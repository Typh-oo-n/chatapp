defmodule ChatappWeb.Presence do
  use Phoenix.Presence, otp_app: :chatapp, pubsub_server: Chatapp.PubSub
end
