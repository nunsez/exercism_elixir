defmodule HelloWorldTest do
  use ExUnit.Case
  doctest HelloWorld

  test "says 'Hello, World!'" do
    assert HelloWorld.hello() == "Hello, World!"
  end
end
