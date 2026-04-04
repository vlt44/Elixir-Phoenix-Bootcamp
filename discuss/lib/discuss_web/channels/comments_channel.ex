defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel
  alias Discuss.{Comment, Topic, Repo}
  import Ecto

  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)

    topic =
      Topic
      |> Repo.get(topic_id)
      |> Repo.preload(comments: [:user])

    comments = Enum.map(topic.comments, &comment_payload/1)

    {:ok, %{comments: comments}, assign(socket, :topic, topic)}
  end

  def handle_in(name, %{"content" => content}, socket) do
    topic = socket.assigns.topic
    user_id = Map.get(socket.assigns, :user_id)

    changeset =
      topic
      |> build_assoc(:comments, user_id: user_id)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        comment = Repo.preload(comment, :user)

        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{
          comment: comment_payload(comment)
        })

        {:reply, :ok, socket}

      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  defp comment_payload(comment) do
    %{
      content: comment.content,
      user_email: comment.user && comment.user.email
    }
  end
end
