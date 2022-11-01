defmodule HighScore do
  @moduledoc """
  In this exercise, you're implementing a way to keep track of the high scores
  for the most popular game in your local arcade hall.

  Tasks:

  1. Define a new high score map
  2. Add players to the high score map
  3. Remove players from the score map
  4. Reset a player's score
  5. Update a player's score
  6. Get a list of players
  """

  @initial_score 0

  @spec new :: map()
  defdelegate new, to: Map

  @spec add_player(map(), String.t(), integer()) :: map()
  defdelegate add_player(scores, name, score \\ @initial_score), to: Map, as: :put

  @spec remove_player(map(), String.t()) :: map()
  defdelegate remove_player(scores, name), to: Map, as: :delete

  @spec reset_score(map(), String.t()) :: map()
  def reset_score(scores, name), do: Map.put(scores, name, @initial_score)

  @spec update_score(map(), String.t(), integer()) :: map()
  def update_score(scores, name, score) do
    Map.update(scores, name, score, fn(existing_value) -> score + existing_value end)
  end

  @spec get_players(map()) :: list()
  defdelegate get_players(scores), to: Map, as: :keys
end
