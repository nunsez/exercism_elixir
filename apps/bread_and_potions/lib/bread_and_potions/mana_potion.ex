defmodule BreadAndPotions.ManaPotion do
  @moduledoc """
  `ManaPotion` struct
  """

  alias BreadAndPotions.Character
  alias BreadAndPotions.Edible
  alias BreadAndPotions.EmptyBottle
  alias BreadAndPotions.ManaPotion

  defstruct [strength: 10]

  @type t() :: %__MODULE__{}

  defimpl Edible, for: ManaPotion do
    @spec eat(ManaPotion.t(), Character.t()) :: {EmptyBottle.t(), Character.t()}
    def eat(item, character) do
      {%EmptyBottle{}, %{character | mana: character.mana + item.strength}}
    end
  end
end
