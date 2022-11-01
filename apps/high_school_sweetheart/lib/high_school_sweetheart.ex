defmodule HighSchoolSweetheart do
  @moduledoc """
  In this exercise, you are going to help high school sweethearts profess
  their love on social media by generating an ASCII heart with their initials.

       ******       ******
     **      **   **      **
   **         ** **         **
  **            *            **
  **                         **
  **     J. K.  +  M. B.     **
   **                       **
     **                   **
       **               **
         **           **
           **       **
             **   **
               ***
                *

  Tasks:

  1. Get the name's first letter
  2. Format the first letter as an initial
  3. Split the full name into the first name and the last name
  4. Put the initials inside of the heart
  """

  @spec first_letter(String.t()) :: String.t() | nil
  def first_letter(name) do
    name
    |> String.trim()
    |> String.first()
  end

  @spec initial(String.t()) :: String.t()
  def initial(name) do
    name
    |> first_letter()
    |> String.upcase()
    |> Kernel.<>(".")
  end

  @spec initials(String.t()) :: String.t()
  def initials(full_name) do
    [first_name, second_name] = String.split(full_name)

    "#{initial(first_name)} #{initial(second_name)}"
  end

  @spec pair(String.t(), String.t()) :: String.t()
  def pair(full_name1, full_name2) do
    i1 = initials(full_name1)
    i2 = initials(full_name2)

    """
         ******       ******
       **      **   **      **
     **         ** **         **
    **            *            **
    **                         **
    **     #{i1}  +  #{i2}     **
     **                       **
       **                   **
         **               **
           **           **
             **       **
               **   **
                 ***
                  *
    """
  end
end
