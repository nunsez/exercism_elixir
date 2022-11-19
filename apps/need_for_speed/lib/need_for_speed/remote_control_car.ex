defmodule NeedForSpeed.RemoteControlCar do
  @moduledoc """
  `RemoteControlCar` struct
  """

  defstruct [
    :nickname,
    :color,
    battery_percentage: 100,
    distance_driven_in_meters: 0
  ]

  @type t() :: %__MODULE__{}

  @spec new(:red | :blue | :green, String.t()) :: t()
  def new(color, nickname) when color in [:red, :blue, :green] do
    %NeedForSpeed.RemoteControlCar{nickname: nickname, color: color}
  end

  @spec display_distance(t()) :: String.t()
  def display_distance(%NeedForSpeed.RemoteControlCar{distance_driven_in_meters: d}) do
    "#{d} meters"
  end

  @spec display_battery(t()) :: String.t()
  def display_battery(%NeedForSpeed.RemoteControlCar{battery_percentage: 0}) do
    "Battery empty"
  end

  def display_battery(%NeedForSpeed.RemoteControlCar{battery_percentage: b}) do
    "Battery at #{b}%"
  end
end
