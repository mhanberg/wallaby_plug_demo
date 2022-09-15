defmodule WallabyPlugDemo.Plug do
  use Plug.Router

  plug(Plug.Static, at: "/", from: "javascript-app/dist")

  plug(:match)
  plug(:dispatch)

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
