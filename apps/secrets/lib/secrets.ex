defmodule Secrets do
  @moduledoc """
  In this exercise, you've been tasked with writing the software
  for an encryption device that works by performing transformations on data.
  You need a way to flexibly create complicated functions
  by combining simpler functions together.

  For each task, return an anonymous function that
  can be invoked from the calling scope.

  All functions should expect integer arguments.
  Integers are also suitable for performing bitwise operations in Elixir.

  Tasks:

  1. Create an adder
  2. Create a subtractor
  3. Create a multiplier
  4. Create a divider
  5. Create an "and"-er
  6. Create an "xor"-er
  7. Create a function combiner
  """

  @spec secret_add(integer()) :: (integer() -> integer())
  def secret_add(secret) do
    fn(value) -> value + secret end
  end

  @spec secret_subtract(integer()) :: (integer() -> integer())
  def secret_subtract(secret) do
    fn(value) -> value - secret end
  end

  @spec secret_multiply(integer()) :: (integer() -> integer())
  def secret_multiply(secret) do
    fn(value) -> value * secret end
  end

  @spec secret_divide(integer()) :: (integer() -> integer())
  def secret_divide(secret) do
    fn(value) -> div(value, secret) end
  end

  @spec secret_and(integer()) :: (integer() -> integer())
  def secret_and(secret) do
    fn(value) -> Bitwise.band(value, secret) end
  end

  @spec secret_xor(integer()) :: (integer() -> integer())
  def secret_xor(secret) do
    fn(value) -> Bitwise.bxor(value, secret) end
  end

  @spec secret_combine(fun(), fun()) :: (integer() -> integer())
  def secret_combine(secret_function1, secret_function2), do: fn(value) ->
    value |> secret_function1.() |> secret_function2.()
  end
end
