defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller
  plug(Ueberauth)

  def callback(conn, _params) do
    IO.inspect(conn.assigns[:ueberauth_auth])
  end
end
