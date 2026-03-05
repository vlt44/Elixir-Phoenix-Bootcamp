defmodule Discuss.Comments do
  use DiscussWeb, :model

  schema "comments" do
    field(:content, :string)
    belongs_to(:user, Discuss.User)
    belongs_to(:topic, Discuss.Topic)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
