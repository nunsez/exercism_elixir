defmodule NeedForSpeed.Race do
  @moduledoc """
  `Race` struct
  """

  defstruct [
    :title,
    :total_distance_in_meters,
    cars: []
  ]

  @type t() :: %__MODULE__{}
  @type status() :: String.t()

  @spec display_status(t()) :: status()
  def display_status(%NeedForSpeed.Race{} = race) do
    cond do
      Enum.any?(race.cars, &(&1.distance_driven_in_meters >= race.total_distance_in_meters)) ->
        "Finished"

      Enum.any?(race.cars, &(&1.distance_driven_in_meters > 0)) ->
        "In Progress"

      true ->
        "Not Started"
    end
  end

  @spec display_distance(t()) :: String.t()
  def display_distance(%NeedForSpeed.Race{total_distance_in_meters: d}) do
    "#{d} meters"
  end
end
