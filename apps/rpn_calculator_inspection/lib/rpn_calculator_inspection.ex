defmodule RPNCalculatorInspection do
  @moduledoc """
  Your work at _Instruments of Texas_ on an experimental RPN calculator continues.
  Your team has built a few prototypes that need to undergo a thorough
  inspection, to choose the best one that can be mass-produced.

  You want to conduct two types of checks.

  Firstly, a reliability check that will detect inputs for which the calculator
  under inspection either crashes or doesn't respond fast enough. To isolate
  failures, the calculations for each input need to be run in a separate process.
  Linking and trapping exits in the caller process can be used to detect if the
  calculation finished or crashed.

  Secondly, a correctness check that will check if for a given input, the result
  returned by the calculator is as expected. Only calculators that already passed
  the reliability check will undergo a correctness check, so crashes are not a
  concern. However, the operations should be run concurrently to speed up the
  process, which makes it the perfect use case for asynchronous tasks.

  Tasks:

  1. Start a reliability check for a single input
  2. Interpret the results of a reliability check
  3. Run a concurrent reliability check for many inputs
  4. Run a concurrent correctness check for many inputs
  """

  @type calculator() :: (String.t() -> number())
  @type check() :: %{input: String.t(), pid: pid()}
  @type check_results() :: %{String.t() => :ok | :error | :timeout}

  @spec start_reliability_check(calculator(), String.t()) :: check()
  def start_reliability_check(calculator, input) do
    %{
      input: input,
      pid: spawn_link(fn -> calculator.(input) end)
    }
  end

  @spec await_reliability_check_result(check(), check_results()) :: check_results()
  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _reason} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  @spec reliability_check(calculator(), [String.t()]) :: check_results()
  def reliability_check(calculator, inputs) do
    old_trap_exit = Process.flag(:trap_exit, true)

    inputs
    |> Enum.map(&start_reliability_check(calculator, &1))
    |> Enum.reduce(%{}, &await_reliability_check_result/2)
    |> tap(fn(_results) -> Process.flag(:trap_exit, old_trap_exit) end)
  end

  @timeout 100

  @spec correctness_check(calculator(), [String.t()]) :: [number()]
  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(&Task.async(fn -> calculator.(&1) end))
    |> Task.await_many(@timeout)
  end
end
