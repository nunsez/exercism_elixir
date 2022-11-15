defmodule KitchenCalculator do
  @moduledoc """
  While preparing to bake cookies for your friends, you have found that you
  have to convert some of the measurements used in the recipe. Being only
  familiar with the metric system, you need to come up with a way to convert
  common US baking measurements to milliliters (mL) for your own ease.

  Use this conversion chart for your solution:

  | Unit to convert | volume | in milliliters (mL) |
  | --------------- | ------ | ------------------- |
  | mL              | 1      | 1                   |
  | US cup          | 1      | 240                 |
  | US fluid ounce  | 1      | 30                  |
  | US teaspoon     | 1      | 5                   |
  | US tablespoon   | 1      | 15                  |

  Being a talented programmer in training, you decide to use milliliters as
  a transition unit to facilitate the conversion from any unit listed to
  any other (even itself).

  Tasks:

  1. Get the numeric component from a volume-pair
  2. Convert the volume-pair to milliliters
  3. Convert the milliliter volume-pair to another unit
  4. Convert from any unit to any unit
  """

  @type volume_pair :: {atom(), number()}

  @teaspoon 5.0
  @tablespoon 15.0
  @fluid_ounce 30.0
  @cup 240.0

  @spec get_volume(volume_pair()) :: number()
  def get_volume({_, value}), do: value

  @spec to_milliliter(volume_pair()) :: volume_pair()
  def to_milliliter({:cup, value}), do: {:milliliter, value * @cup}

  def to_milliliter({:fluid_ounce, value}), do: {:milliliter, value * @fluid_ounce}

  def to_milliliter({:teaspoon, value}), do: {:milliliter, value * @teaspoon}

  def to_milliliter({:tablespoon, value}), do: {:milliliter, value * @tablespoon}

  def to_milliliter({:milliliter, _} = volume_pair), do: volume_pair

  @spec from_milliliter(volume_pair(), atom()) :: volume_pair()
  def from_milliliter({_, value}, :cup = unit), do: {unit, value / @cup}

  def from_milliliter({_, value}, :fluid_ounce = unit), do: {unit, value / @fluid_ounce}

  def from_milliliter({_, value}, :teaspoon = unit), do: {unit, value / @teaspoon}

  def from_milliliter({_, value}, :tablespoon = unit), do: {unit, value / @tablespoon}

  def from_milliliter(volume_pair, :milliliter), do: volume_pair

  @spec convert(volume_pair(), atom()) :: volume_pair()
  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end
end
