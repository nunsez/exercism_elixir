defmodule BreadAndPotions.LoafOfBread do
  @moduledoc """
  `LoafOfBread` struct
  """

  alias BreadAndPotions.Character
  alias BreadAndPotions.Edible
  alias BreadAndPotions.LoafOfBread

  defstruct []

  @type t() :: %__MODULE__{}

  defimpl Edible, for: LoafOfBread do
    @spec eat(LoafOfBread.t(), Character.t()) :: {nil, Character.t()}
    def eat(_item, character) do
      {nil, %{character | health: character.health + 5}}
    end
  end
end
