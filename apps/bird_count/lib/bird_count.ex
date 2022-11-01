defmodule BirdCount do
  @moduledoc """
  You're an avid bird watcher that keeps track of how many birds have visited
  your garden on any given day.

  You decided to bring your bird watching to a new level and implement a few
  tools that will help you track and process the data.

  You have chosen to store the data as a list of integers. The first number
  in the list is the number of birds that visited your garden today, the second
  yesterday, and so on.

  Tasks:

  1. Check how many birds visited today
  2. Increment today's count
  3. Check if there was a day with no visiting birds
  4. Calculate the total number of visiting birds
  5. Calculate the number of busy days
  """

  @busy_threshold 5

  @spec today(list()) :: integer() | nil
  def today([]), do: nil

  defdelegate today(list), to: Kernel, as: :hd

  @spec increment_day_count(list()) :: list()
  def increment_day_count([]), do: [1]

  def increment_day_count([head | tail]), do: [head + 1 | tail]

  @spec has_day_without_birds?(list()) :: boolean()
  def has_day_without_birds?(list), do: 0 in list

  @spec total(list()) :: integer()
  def total([]), do: 0

  def total([head | tail]), do: head + total(tail)

  @spec busy_days(list()) :: integer()
  def busy_days([]), do: 0

  def busy_days([head | tail]) when head >= @busy_threshold, do: 1 + busy_days(tail)

  def busy_days([_head | tail]), do: busy_days(tail)
end
