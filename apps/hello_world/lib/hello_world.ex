defmodule HelloWorld do
  @moduledoc """
  The classical introductory exercise. Just say "Hello, World!".

  "Hello, World!" is the traditional first program for beginning programming in a new language or environment.
  """

  @spec hello :: String.t()
  def hello, do: "Hello, World!"
end
