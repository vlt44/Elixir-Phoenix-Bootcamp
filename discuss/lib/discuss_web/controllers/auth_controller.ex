defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug(Ueberauth)

  alias DiscussWeb.User

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{
      token: auth.credentials.token,
      email: auth.info.email,
      provider: to_string(auth.provider)
    }

    changeset = User.changeset(%User{}, user_params)

    insert_or_update_user(conn, changeset)
  end

  defp insert_or_update_user(conn, changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset)
      user -> {:ok, user}
    end
  end
end
