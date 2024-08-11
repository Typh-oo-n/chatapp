defmodule Chatapp.Messages.Message do
  use Ecto.Schema
  import Ecto.Changeset

  # alias Chatapp.Accounts.User

  schema "messages" do
    field :body, :string
    field :user_id, :id
    # belongs_to :user, User, foreign_key: :user_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :user_id])
    |> validate_required([:body, :user_id])
  end
end
