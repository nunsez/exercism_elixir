defmodule GuessingGame do
  @moduledoc """
  You are creating a trivial online game where a friend can guess a secret
  number. You want to give some feedback, but not give away the answer with a
  guess. You need to devise a function to provide different responses depending
  on how the guess relates to the secret number.

  | Condition                                                     | Response       |
  | ------------------------------------------------------------- | -------------- |
  | When the guess matches the secret number                      | "Correct"      |
  | When the guess is one more or one less than the secret number | "So close"     |
  | When the guess is greater than the secret number              | "Too high"     |
  | When the guess is less than the secret number                 | "Too low"      |
  | When a guess isn't made                                       | "Make a guess" |

  All guesses and secret numbers are integer numbers.

  Tasks:

  1. Make the response when the guess matches the secret number
  2. Make the response when the guess is greater than the secret number
  3. Make the response when the guess is less than the secret number
  4. Make the responses when the guess is one more or one less than the secret number
  5. Make the response when there is no guess
  """

  @spec compare(integer(), integer() | atom()) :: String.t()
  def compare(_, guess \\ :no_guess)

  def compare(_, guess) when not is_integer(guess), do: "Make a guess"

  def compare(secret_number, guess) when guess == secret_number, do: "Correct"

  def compare(secret_number, guess) when abs(guess - secret_number) <= 1, do: "So close"

  def compare(secret_number, guess) when guess > secret_number, do: "Too high"

  def compare(secret_number, guess) when guess < secret_number, do: "Too low"
end
