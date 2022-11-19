defmodule RPGCharacterSheet do
  @moduledoc """
  You and your friends love to play pen-and-paper role-playing games,
  but you noticed that it's difficult to get new people to join your group.
  They often struggle with character creation. They don't know where to start.
  To help new players out, you decided to write a small program that will guide
  them through the process.

  Tasks:

  1. Welcome the new player
  2. Ask for the character's name
  3. Ask for the character's class
  4. Ask for the character's level
  5. Combine previous steps into one
  """

  @type character :: %{name: String.t(), class: String.t(), level: integer()}

  @spec welcome :: :ok
  def welcome do
    IO.puts("Welcome! Let's fill out your character sheet together.")
  end

  @spec ask_name :: String.t()
  def ask_name do
    IO.gets("What is your character's name?\n")
    |> String.trim()
  end

  @spec ask_class :: String.t()
  def ask_class do
    IO.gets("What is your character's class?\n")
    |> String.trim()
  end

  @spec ask_level :: integer()
  def ask_level do
    IO.gets("What is your character's level?\n")
    |> String.trim()
    |> String.to_integer()
  end

  @spec run :: character()
  def run do
    welcome()

    Map.new
    |> Map.put(:name, ask_name())
    |> Map.put(:class, ask_class())
    |> Map.put(:level, ask_level())
    |> IO.inspect(label: "Your character")
    # credo:disable-for-previous-line Credo.Check.Warning.IoInspect
  end
end
