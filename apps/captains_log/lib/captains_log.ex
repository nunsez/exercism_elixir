defmodule CaptainsLog do
  @moduledoc """
  Mary is a big fan of the TV series _Star Trek: The Next Generation_. She often
  plays pen-and-paper role playing games, where she and her friends pretend to be
  the crew of the _Starship Enterprise_. Mary's character is Captain Picard, which
  means she has to keep the captain's log. She loves the creative part of the
  game, but doesn't like to generate random data on the spot.

  Help Mary by creating random generators for data commonly appearing in the
  captain's log.

  Tasks:

  1. Generate a random planet
  2. Generate a random starship registry number
  3. Generate a random stardate
  4. Format the stardate
  """

  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  @spec random_planet_class :: String.t()
  def random_planet_class, do: Enum.random(@planetary_classes)

  @spec random_ship_registry_number :: String.t()
  def random_ship_registry_number(), do: "NCC-#{Enum.random(1_000..9_999)}"

  @start 41_000.0
  @finish 42_000.0

  @spec random_stardate :: float()
  def random_stardate, do: :rand.uniform() * (@finish - @start) + @start

  @spec format_stardate(float()) :: String.t()
  def format_stardate(stardate) do
    "~.1f"
    |> :io_lib.format([stardate])
    |> to_string()
  end
end
