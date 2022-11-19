defmodule BreadAndPotions.Poison do
  @moduledoc """
  `Poison` struct
  """

  alias BreadAndPotions.Character
  alias BreadAndPotions.Edible
  alias BreadAndPotions.EmptyBottle
  alias BreadAndPotions.Poison

  defstruct []

  @type t() :: %__MODULE__{}

  defimpl Edible, for: Poison do
    @spec eat(Poison.t(), Character.t()) :: {EmptyBottle.t(), Character.t()}
    def eat(_item, character) do
      {%EmptyBottle{}, %{character | health: 0}}
    end
  end
end
