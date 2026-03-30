defmodule Discuss.CommentsChannel do
  use DiscussWeb, :channel

  def join(name, _params, socket) do
    IO.inspect(name)
    {:ok, %{hey: "there"}, socket}
  end

  def handle_in(name, socket) do
    {:reply, :ok, socket}
  end
end
