defmodule RPG.LoafOfBread do
  defstruct []

  defimpl RPG.Edible, for: RPG.LoafOfBread do
    def eat(_item, character) do
      {nil, %{character | health: character.health + 5}}
    end
  end
end
