defprotocol RPG.Edible do
  alias RPG.Character

  @spec eat(struct(), %Character{}) :: {struct() | nil, %Character{}}
  def eat(item, character)
end
