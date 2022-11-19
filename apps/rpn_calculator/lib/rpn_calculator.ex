defmodule RPNCalculator do
  @moduledoc """
  While working at _Instruments of Texas_, you are tasked to work on an
  experimental Reverse Polish Notation [RPN] calculator written in Elixir. Your
  team is having a problem with some operations raising errors and crashing the
  process. You have been tasked to write a function which wraps the operation
  function so that the errors can be handled more elegantly with idiomatic Elixir
  code.

  Tasks:

  1. Warn the team
  2. Wrap the error
  3. Pass on the message
  """

  @spec calculate!(list(), fun()) :: {:ok, any()}
  def calculate!(stack, operation), do: operation.(stack)

  @spec calculate(list(), fun()) :: {:ok, any()} | :error
  def calculate(stack, operation) do
    {:ok, calculate!(stack, operation)}
  rescue
    _ -> :error
  end

  @spec calculate_verbose(list(), fun()) :: {:ok, any()} | {:error, String.t()}
  def calculate_verbose(stack, operation) do
    {:ok, calculate!(stack, operation)}
  rescue
    e -> {:error, Exception.message(e)}
  end
end
