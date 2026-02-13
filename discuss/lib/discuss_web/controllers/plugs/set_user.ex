defmodule DiscussWeb.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias DiscussWeb.Repo
  alias DiscussWeb.User
  alias DiscussWeb.Router.Helpers, as: Routes

  def init(_params) do
  end

  def call(conn, _params) do
  end
end
