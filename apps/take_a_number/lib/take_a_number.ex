defmodule TakeANumber do
  @moduledoc """
  You are writing an embedded system for a Take-A-Number machine.
  It is a very simple model. It can give out consecutive numbers and
  report what was the last number given out.

  Tasks:

  1. Start the machine
  2. Report the machine state
  3. Give out numbers
  4. Stop the machine
  5. Ignore unexpected messages
  """

  @initial_state 0

  @spec start :: pid()
  def start, do: spawn(fn -> loop(@initial_state) end)

  @spec loop(integer()) :: :ok
  defp loop(state) do
    receive do
      {:report_state, sender_pid} -> send(sender_pid, state) |> loop()
      {:take_a_number, sender_pid} -> send(sender_pid, state + 1) |> loop()
      :stop -> :ok
      _ -> loop(state)
    end
  end
end
