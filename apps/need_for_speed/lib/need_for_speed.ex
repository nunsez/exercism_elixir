defmodule NeedForSpeed do
  @moduledoc """
  That remote controlled car that you bought recently has turned into a whole new
  hobby. You have been organizing remote control car races.

  You were almost finished writing a program that would allow to run race
  simulations when your cat jumped at your keyboard and deleted a few lines of
  code. Now your program doesn't compile anymore...

  Tasks:

  1. Fix compilation error `Race.__struct__/0 is undefined`
  2. Fix compilation error `Car.__struct__/0 is undefined`
  3. Fix compilation error `undefined function puts/1`
  4. Fix compilation error `undefined function default_color/0`
  """

  # Add missing aliases and imports here.
  alias NeedForSpeed.Race
  alias NeedForSpeed.RemoteControlCar, as: Car

  import IO, only: [puts: 1]
  import IO.ANSI, except: [color: 1]

  # Do not edit the code below.

  @spec print_race(Race.t()) :: :ok
  def print_race(%Race{} = race) do
    puts("""
    🏁 #{race.title} 🏁
    Status: #{Race.display_status(race)}
    Distance: #{Race.display_distance(race)}
    Contestants:
    """)

    race.cars
    |> Enum.sort_by(&(-1 * &1.distance_driven_in_meters))
    |> Enum.with_index()
    |> Enum.each(fn {car, index} -> print_car(car, index + 1) end)
  end

  @spec print_car(Car.t(), pos_integer()) :: :ok
  defp print_car(%Car{} = car, index) do
    color = color(car)

    puts("""
      #{index}. #{color}#{car.nickname}#{default_color()}
      Distance: #{Car.display_distance(car)}
      Battery: #{Car.display_battery(car)}
    """)
  end

  @spec color(Car.t()) :: String.t()
  defp color(%Car{} = car) do
    case car.color do
      :red -> red()
      :blue -> cyan()
      :green -> green()
    end
  end
end
