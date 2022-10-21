defmodule LanguageList do
  @moduledoc """
  In this exercise you need to implement some functions
  to manipulate a list of programming languages.

  Tasks:

  1. Define a function to return an empty language list
  2. Define a function to add a language to the list
  3. Define a function to remove a language from the list
  4. Define a function to return the first item in the list
  5. Define a function to return how many languages are in the list
  6. Define a function to determine if the list includes a functional language
  """

  @spec new :: list()
  def new, do: []

  @spec add(list(), any()) :: list()
  def add(list, language), do: [language | list]

  @spec remove(list()) :: list()
  defdelegate remove(list), to: Kernel, as: :tl

  @spec first(list()) :: any()
  defdelegate first(list), to: Kernel, as: :hd

  @spec count(list()) :: integer()
  defdelegate count(list), to: Kernel, as: :length

  @spec functional_list?(list()) :: boolean()
  def functional_list?(list), do: "Elixir" in list
end
