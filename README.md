# WallabyPlugJSDemo

This app was designed to demonstrate how you might be a Wallaby test suite for a JS app that exists outside of the Elixir app, or existing without _any_ Elixir app.

The basics here are we bootstrap a basic Plug web server that will serve your JS app with the `Plug.Static` module.

```elixir
defmodule WallabyPlugDemo.Plug do
  use Plug.Router

  plug(Plug.Static, at: "/", from: "javascript-app/dist")

  plug(:match)
  plug(:dispatch)

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
```
We show the bare minimum needed to get the test suite to compile your app before your tests. If your app will not live in this repo, you can always just change the path of the `Plug.Static` config and the `compile_assets/1` to point to wherever the project is

In CI, you could have it clone the JS app as well to get it.

```elixir
defmodule WallabyPlugDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :wallaby_plug_demo,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: [
        test: ["assets.compile", "test"],
        "assets.compile": &compile_assets/1
      ]
    ]
  end

  defp compile_assets(_) do
    Mix.shell().cmd("yarn build",
      cd: "javascript-app",
      quiet: true
    )
  end

  # ...
end
```

And we have our feature test!

```elixir
defmodule ExampleFeatureTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  import Wallaby.Query

  feature "counter works", %{session: session} do
    session
    |> visit("/index.html")
    |> assert_text("Vite + Wallaby + React")
    |> assert_text("count is 0")
    |> click(button("counter"))
    |> assert_text("count is 1")
    |> click(button("counter"))
    |> click(button("counter"))
    |> click(button("counter"))
    |> assert_text("count is 4")
  end
end
```

Voila!
