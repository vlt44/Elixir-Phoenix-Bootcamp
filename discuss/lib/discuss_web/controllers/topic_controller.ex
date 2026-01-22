defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller
  alias Discuss.Topic

  def new(conn, params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, :new, changeset: changeset)
  end

  def create() do
  end
end
