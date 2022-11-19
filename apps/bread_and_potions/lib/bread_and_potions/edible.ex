defprotocol BreadAndPotions.Edible do
  @moduledoc """
  `Edible` protocol
  """

  alias BreadAndPotions.Character

  @spec eat(struct(), Character.t()) :: {struct() | nil, Character.t()}
  def eat(item, character)
end
