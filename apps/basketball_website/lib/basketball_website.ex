defmodule BasketballWebsite do
  @moduledoc """
  You are working with a web development team to maintain a website for a local
  basketball team.
  The web development team is less familiar with Elixir and is asking for a
  function to be able to extract data from a series of nested maps to
  facilitate rapid development.

  Tasks:

  1. Extract data from a nested map structure
  2. Refactor using included functions
  """

  @spec extract_from_path(map(), String.t() | [String.t()]) :: any()
  def extract_from_path(data, []), do: data
  def extract_from_path(data, [key | rest]), do: extract_from_path(data[key], rest)
  def extract_from_path(data, path), do: extract_from_path(data, String.split(path, "."))

  @spec get_in_path(map(), String.t()) :: any()
  def get_in_path(data, path), do: get_in(data, String.split(path, "."))
end
