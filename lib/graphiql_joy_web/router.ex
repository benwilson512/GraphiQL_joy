defmodule Redirect do
  def init(opts), do: opts
  def call(conn, opts) do
    conn
    |> Phoenix.Controller.redirect(opts)
    |> Plug.Conn.halt()
  end
end

defmodule GraphiqlJoyWeb.Router do
  use GraphiqlJoyWeb, :router

  pipeline :graphql do
    plug(:conn_to_absinthe_context)
  end

  get("/", Redirect, to: "/graphiql")

  scope "/" do    
    pipe_through(:graphql)

    forward("/api", Absinthe.Plug, schema: GraphiqlJoy.Schema)
    forward("/graphiql", Absinthe.Plug.GraphiQL, 
        schema: GraphiqlJoy.Schema)
  end

  defp conn_to_absinthe_context(conn, _opts) do
    Plug.Conn.put_private(conn, :absinthe, %{context: %{}})
  end
end
