defmodule BoutiqueSuggestions do
  @moduledoc """
  Your work at the online fashion boutique store continues. You come up with the
  idea for a website feature where an outfit is suggested to the user. While you
  want to give lots of suggestions, you don't want to give bad suggestions, so
  you decide to use a list comprehension since you can easily _generate_ outfit
  combinations, then _filter_ them by some criteria.

  Clothing items are stored as a map:

  ```elixir
  %{
    item_name: "Descriptive Name",
    price: 99.00,
    base_color: "red"
  }
  ```

  Tasks:

  1. Suggest a combination
  2. Filter out clashing outfits
  3. Filter by combination price
  """

  @default_maximum_price 100.0

  @spec get_combinations([map()], [map()], keyword() | nil) :: [{map(), map()}]
  def get_combinations(tops, bottoms, options \\ [])

  def get_combinations(tops, bottoms, options) do
    maximum_price = Keyword.get(options, :maximum_price, @default_maximum_price)

    for top <- tops,
        bottom <- bottoms,
        top.base_color != bottom.base_color,
        top.price + bottom.price <= maximum_price do
      {top, bottom}
    end
  end
end
