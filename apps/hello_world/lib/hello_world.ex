defmodule HelloWorld do
  @moduledoc """
  The classical introductory exercise. Just say "Hello, World!".

  "Hello, World!" is the traditional first program for beginning programming in a new language or environment.
  """

  @doc """
  Simply returns "Hello, World!"
  """
  @spec hello :: String.t()
  def hello, do: "Hello, World!"
end
