defmodule BoutiqueInventory do
  @moduledoc """
  You are running an online fashion boutique. Your big annual sale is coming up,
  so you need to take stock of your inventory to make sure you're ready.

  A single item in the inventory is represented by a map, and the whole inventory
  is a list of such maps.

  ```elixir
  %{
    name: "White Shirt",
    price: 40,
    quantity_by_size: %{s: 3, m: 7, l: 8, xl: 4}
  }
  ```

  Tasks:

  1. Sort items by price
  2. Find all items with missing prices
  3. Update item names
  4. Increment the item's quantity
  5. Calculate the item's total quantity
  """

  @type item :: %{
    name: String.t(),
    price: non_neg_integer(),
    quantity_by_size: %{optional(atom()) => non_neg_integer()}
  }

  @type t :: [item()]

  @spec sort_by_price(t()) :: t()
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, fn(item) -> item.price end)
  end

  @spec with_missing_price(t()) :: t()
  def with_missing_price(inventory) do
    Enum.filter(inventory, fn(item) -> !item.price end)
  end

  @spec update_names(t(), String.t(), String.t()) :: t()
  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn(item) ->
      new_name = String.replace(item.name, old_word, new_word)

      %{item | name: new_name}
    end)
  end

  @spec increase_quantity(item(), integer()) :: item()
  def increase_quantity(item, count) do
    new_quantity = Map.new(
      item.quantity_by_size,
      fn({size, quantity}) -> {size, quantity + count} end
    )

    %{item | quantity_by_size: new_quantity}
  end

  @spec total_quantity(item()) :: non_neg_integer()
  def total_quantity(item) do
    Enum.reduce(
      item.quantity_by_size,
      0,
      fn({_size, quantity}, acc) -> acc + quantity end
    )
  end
end
