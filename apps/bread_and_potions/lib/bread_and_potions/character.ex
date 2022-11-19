defmodule BreadAndPotions.Character do
  @moduledoc """
  `Character` struct
  """

  defstruct [health: 100, mana: 0]

  @type t() :: %__MODULE__{}
end
