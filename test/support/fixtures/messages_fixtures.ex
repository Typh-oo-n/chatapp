defmodule Chatapp.MessagesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chatapp.Messages` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    {:ok, message} =
      attrs
      |> Enum.into(%{
        body: "some body"
      })
      |> Chatapp.Messages.create_message()

    message
  end
end
