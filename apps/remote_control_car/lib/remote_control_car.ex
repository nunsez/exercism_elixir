defmodule RemoteControlCar do
  @moduledoc """
  In this exercise you'll be playing around with a remote controlled car, which
  you've finally saved enough money for to buy.

  Cars start with full (100%) batteries. Each time you drive the car using the
  remote control, it covers 20 meters and drains one percent of the battery.
  The car's nickname is not known until it is created.

  The remote controlled car has a fancy LED display that shows two bits of
  information:

  - The total distance it has driven, displayed as: `"<METERS> meters"`.
  - The remaining battery charge, displayed as: `"Battery at <PERCENTAGE>%"`.

  If the battery is at 0%, you can't drive the car anymore and the battery
  display will show `"Battery empty"`.

  Tasks:

  1. Create a brand-new remote controlled car
  2. Create a brand-new remote controlled car with a nickname
  3. Display the distance
  4. Display the battery percentage
  5. Driving changes the battery and distance driven
  6. Account for driving with a dead battery
  """

  @enforce_keys [:nickname]
  defstruct [
    battery_percentage: 100,
    distance_driven_in_meters: 0,
    nickname: "none"
  ]

  @battery_consumption_per_drive_session 1
  @distance_traveled_per_drive_session 20

  @type t() :: %__MODULE__{
    battery_percentage: non_neg_integer(),
    distance_driven_in_meters: non_neg_integer(),
    nickname: String.t()
  }

  @spec new(String.t()) :: t()
  def new(nickname \\ "none"), do: %__MODULE__{nickname: nickname}

  @spec display_distance(t()) :: String.t()
  def display_distance(remote_car) when is_struct(remote_car, __MODULE__) do
    "#{remote_car.distance_driven_in_meters} meters"
  end

  @spec display_battery(t()) :: String.t()
  def display_battery(remote_car) when is_struct(remote_car, __MODULE__) do
    case remote_car.battery_percentage do
      0 -> "Battery empty"
      value -> "Battery at #{value}%"
    end
  end

  @spec drive(t()) :: t()
  def drive(%{:battery_percentage => 0} = remote_car) when is_struct(remote_car, __MODULE__) do
    remote_car
  end

  def drive(remote_car) when is_struct(remote_car, __MODULE__) do
    remote_car
    |> Map.update!(:battery_percentage, fn(val) ->
      val - @battery_consumption_per_drive_session
    end)
    |> Map.update!(:distance_driven_in_meters, fn(val) ->
      val + @distance_traveled_per_drive_session
    end)
  end
end
