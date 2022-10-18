defmodule Lasagna do
  @moduledoc """
  In this exercise you're going to write some code to help you
  cook a brilliant lasagna from your favorite cooking book.

  You have five tasks, all related to the time spent cooking the lasagna.

  Tasks:

  1. Define the expected oven time in minutes
  2. Calculate the remaining oven time in minutes
  3. Calculate the preparation time in minutes
  4. Calculate the total working time in minutes
  5. Create a notification that the lasagna is ready
  """

  @oven_time 40

  @spec expected_minutes_in_oven :: integer()
  def expected_minutes_in_oven, do: @oven_time

  @spec remaining_minutes_in_oven(integer()) :: integer()
  def remaining_minutes_in_oven(actual_minutes) do
    expected_minutes_in_oven() - actual_minutes
  end

  @spec preparation_time_in_minutes(integer()) :: integer()
  def preparation_time_in_minutes(layer_count) do
    minutes_per_layer = 2

    minutes_per_layer * layer_count
  end

  @spec total_time_in_minutes(integer(), integer()) :: integer()
  def total_time_in_minutes(layers, time_in_oven) do
    preparation_time_in_minutes(layers) + time_in_oven
  end

  @spec alarm() :: String.t()
  def alarm, do: "Ding!"
end
