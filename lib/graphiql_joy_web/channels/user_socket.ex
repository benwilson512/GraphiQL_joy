defmodule GraphiqlJoyWeb.UserSocket do
  use Phoenix.Socket
  use Absinthe.Phoenix.Socket, schema: YetiWeb.Schema

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
