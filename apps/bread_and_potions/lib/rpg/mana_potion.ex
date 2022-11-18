defmodule RPG.ManaPotion do
  defstruct [strength: 10]

  defimpl RPG.Edible, for: RPG.ManaPotion do
    def eat(item, character) do
      {%RPG.EmptyBottle{}, %{character | mana: character.mana + item.strength}}
    end
  end
end
