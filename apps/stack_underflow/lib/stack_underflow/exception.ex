defmodule StackUnderflow.Exception do
  @moduledoc false

  alias StackUnderflow.Exception.StackUnderflowError
  alias StackUnderflow.Exception.DivisionByZeroError

  @spec divide([integer()]) :: float()
  def divide(stack) when length(stack) < 2 do
    raise StackUnderflowError, "when dividing"
  end

  def divide([divider, _divisible]) when divider == 0 do
    raise DivisionByZeroError
  end

  def divide([divider, divisible]), do: divisible / divider
end
