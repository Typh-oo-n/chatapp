defmodule Chatapp.Repo do
  use Ecto.Repo,
    otp_app: :chatapp,
    adapter: Ecto.Adapters.MyXQL
end
