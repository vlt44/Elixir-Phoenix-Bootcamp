defmodule DiscussWeb.UserSocket do
  use Phoenix.Socket

  channel("comments:*", DiscussWeb.CommentsChannel)

  transport(:websocket, Phoenix.Transports.WebSocket)

  def connect(%{"token" => token}, socket) do
    case Phoenix.Token.verify(socket, "key", token) do
      {:ok, _user_id} -> {:ok, assign(socket, :user_id, _user_id)}
      {:error, _reason} -> :error
    end
  end

  def id(_socket), do: nil
end
