defmodule Discuss.UserSocket do
  use Phoenix.Socket

  channel("comments:*", Discuss.CommentsChannel)

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
