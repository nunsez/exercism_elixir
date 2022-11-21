defmodule LucasNumbers do
  @moduledoc """
  You are a huge fan of the Numberphile Youtube channel and you just saw a cool
  video about the _Lucas Number Sequence_. You want to create this sequence using
  Elixir.

  While designing your function, you want to make use of lazy evaluation, so that
  you can generate as many numbers as you want, but only if you need to -- So you
  decide to use a stream.

  Lucas numbers are an infinite sequence of numbers which build progressively
  which hold a strong correlation to the golden ratio (φ or ϕ)
  E.g.: 2, 1, 3, 4, 7, 11, 18, 29, ...

  Tasks:

  1. Generate the base cases
  2. Create the generalized case
  3. Catch bad arguments
  """

  @spec generate(pos_integer()) :: [pos_integer()]
  def generate(count) when is_integer(count) and count >= 1 do
    {2, 1}
    |> Stream.unfold(fn({first, second}) -> {first, {second, first + second}} end)
    |> Enum.take(count)
  end

  def generate(_) do
    raise ArgumentError, "count must be specified as an integer >= 1"
  end
end
