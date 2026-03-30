defmodule Discuss.CommentsChannel do
  use DiscussWeb, :channel
  alias Discuss.Topic

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)
    topic = Repo.get(Topic, topic_id)

    {:ok, %{}, socket}
  end

  def handle_in(name, socket) do
    {:reply, :ok, socket}
  end
end
