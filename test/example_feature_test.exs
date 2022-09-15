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
