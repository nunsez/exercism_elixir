defmodule StackUnderflow.Exception.StackUnderflowError do
  @moduledoc false

  @message "stack underflow occurred"

  defexception [message: @message]

  @type t() :: %__MODULE__{}

  @impl Exception
  def exception([]), do: %__MODULE__{}

  def exception(value) do
    %__MODULE__{message: "#{@message}, context: #{value}"}
  end
end
