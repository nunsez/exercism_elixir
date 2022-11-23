defmodule TakeANumberDeluxe do
  @moduledoc """
  The basic Take-A-Number machine was selling really well, but some users were
  complaining about its lack of advanced features compared to other models
  available on the market.

  The manufacturer listened to user feedback and decided to release a deluxe
  model with more features, and you once again were tasked with writing the
  software for this machine.

  The new features added to the deluxe model include:
  - Keeping track of currently queued numbers.
  - Setting the minimum and maximum number. This will allow using multiple
    deluxe Take-A-Number machines for queueing customers to different
    departments at the same facility, and to tell apart the departments by the
    number range.
  - Allowing certain numbers to skip the queue to provide priority service
    to pregnant women and the elderly.
  - Auto shutdown to prevent accidentally leaving the machine on for the
    whole weekend and wasting energy.

  The business logic of the machine was already implemented by your colleague and
  can be found in the module `TakeANumberDeluxe.State`. Now your task is to wrap it
  in a `GenServer`.

  Tasks:

  1. Start the machine
  2. Report machine state
  3. Queue new numbers
  4. Serve next queued number
  5. Reset state
  6. Implement auto shutdown
  """

  use GenServer

  # Client API

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    case GenServer.start_link(__MODULE__, init_arg) do
      {:error, {:bad_return_value, value}} -> value
      result -> result
    end
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report_state)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :queue_new_number)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks

  @impl GenServer
  def init(init_arg) do
    min_number = Keyword.get(init_arg, :min_number)
    max_number = Keyword.get(init_arg, :max_number)
    timeout = Keyword.get(init_arg, :auto_shutdown_timeout)

    result =
      if timeout do
        TakeANumberDeluxe.State.new(min_number, max_number, timeout)
      else
        TakeANumberDeluxe.State.new(min_number, max_number)
      end

    case result do
      {:ok, state} -> {:ok, state, state.auto_shutdown_timeout}
      error -> error
    end
  end

  @impl GenServer
  def handle_call(:report_state, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl GenServer
  def handle_call(:queue_new_number, _from, state) do
    result = TakeANumberDeluxe.State.queue_new_number(state)

    case result do
      {:ok, new_number, new_state} ->
        {:reply, {:ok, new_number}, new_state, new_state.auto_shutdown_timeout}

      error ->
        {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    result = TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number)

    case result do
      {:ok, new_number, new_state} ->
        {:reply, {:ok, new_number}, new_state, new_state.auto_shutdown_timeout}

      error ->
        {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    result = TakeANumberDeluxe.State.new(
      state.min_number,
      state.max_number,
      state.auto_shutdown_timeout
    )

    case result do
      {:ok, new_state} -> {:noreply, new_state, new_state.auto_shutdown_timeout}
      error -> {:stop, :normal, error}
    end
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    {:stop, :normal, state}
  end

  @impl GenServer
  def handle_info(_message, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
