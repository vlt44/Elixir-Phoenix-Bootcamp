defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug(Ueberauth)

  alias Discuss.User
  alias Discuss.Repo

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case auth.info.email do
      nil ->
        conn
        |> put_flash(:error, "GitHub did not provide an email")
        |> redirect(to: ~p"/")

      email ->
        user_params = %{
          token: auth.credentials.token,
          email: email,
          provider: to_string(auth.provider)
        }

        changeset = User.changeset(%User{}, user_params)
        signin(conn, changeset)
    end
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: ~p"/topics")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing you in.")
        |> redirect(to: ~p"/topics")
    end
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: ~p"/topics")
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset)
      user -> {:ok, user}
    end
  end
end
