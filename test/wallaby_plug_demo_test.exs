defmodule WallabyPlugDemoTest do
  use ExUnit.Case
  doctest WallabyPlugDemo

  test "greets the world" do
    assert WallabyPlugDemo.hello() == :world
  end
end
