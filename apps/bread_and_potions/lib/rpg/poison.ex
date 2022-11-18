defmodule RPG.Poison do
  defstruct []

  defimpl RPG.Edible, for: RPG.Poison do
    def eat(_item, character) do
      {%RPG.EmptyBottle{}, %{character | health: 0}}
    end
  end
end
