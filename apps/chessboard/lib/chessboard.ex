defmodule Chessboard do
  @moduledoc """
  As a chess enthusiast, you would like to write your own version of the game.
  Yes, there maybe plenty of implementations of chess available online already,
  but yours will be unique!

  But before you can let your imagination run wild, you need to take care of the
  basics. Let's start by generating the board.

  Each square of the chessboard is identified by a letter-number pair.
  The vertical columns of squares, called files, are labeled A through H.
  The horizontal rows of squares, called ranks, are numbered 1 to 8.

  Tasks:

  1. Define the rank range
  2. Define the file range
  3. Transform the rank range into a list of ranks
  4. Transform the file range into a list of files
  """

  @spec rank_range :: Range.t()
  def rank_range, do: 1..8

  @spec file_range :: Range.t()
  def file_range, do: ?A..?H

  @spec ranks :: [integer()]
  def ranks, do: Enum.to_list(rank_range())

  @spec files :: [String.t()]
  def files, do: Enum.map(file_range(), fn(char) -> <<char>> end)
end
