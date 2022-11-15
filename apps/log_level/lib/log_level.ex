defmodule LogLevel do
  @moduledoc """
  You are running a system that consists of a few applications
  producing many logs.
  You want to write a small program that will aggregate those logs
  and give them labels according to their severity level.
  All applications in your system use the same log codes,
  but some of the legacy applications don't support all the codes.

  Tasks:

  1. Return the logging code label
  2. Send an alert
  """

  @type log_label() :: :trace | :debug | :info | :warning | :error | :fatal | :unknown

  @spec to_label(integer(), boolean()) :: log_label()
  def to_label(level, legacy?) do
    cond do
      level == 0 and not legacy? -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 and not legacy? -> :fatal
      true -> :unknown
    end
  end

  @spec alert_recipient(integer(), boolean()) :: atom() | false
  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)

    cond do
      label in [:error, :fatal] -> :ops
      label == :unknown and legacy? -> :dev1
      label == :unknown and not legacy? -> :dev2
      true -> false
    end
  end
end
