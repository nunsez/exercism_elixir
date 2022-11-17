defmodule CommunityGarden do
  @moduledoc """
  Your community association has asked you to implement a simple registry
  application to manage the community garden registrations. The `Plot` struct
  has already been provided for you.

  Tasks:

  1. Open the garden
  2. List the registrations
  3. Register plots to a person
  4. Release plots
  5. Get a registered plot
  """

  @type plot_not_found :: {:not_found, String.t()}

  @initial_state {[], 1}
  @plot_not_found {:not_found, "plot is unregistered"}

  @spec start :: {:ok, pid()}
  def start, do: Agent.start(fn -> @initial_state end)

  @spec list_registrations(pid()) :: list()
  def list_registrations(pid), do: Agent.get(pid, fn({plots, _}) -> plots end)

  @spec register(pid(), String.t()) :: Plot.t()
  def register(pid, register_to) do
    Agent.get_and_update(pid, fn({plots, id}) ->
      plot = %Plot{plot_id: id, registered_to: register_to}
      new_state = {[plot | plots], id + 1}

      {plot, new_state}
    end)
  end

  @spec release(pid(), pos_integer()) :: :ok
  def release(pid, plot_id) do
    Agent.update(pid, fn({plots, id}) ->
      new_plots = Enum.reject(plots, fn(plot) -> plot.plot_id == plot_id end)

      {new_plots, id}
    end)
  end

  @spec get_registration(pid(), pos_integer()) :: Plot.t() | plot_not_found()
  def get_registration(pid, plot_id) do
    Agent.get(pid, fn({plots, _}) ->
      Enum.find(plots, @plot_not_found, fn(plot) -> plot.plot_id == plot_id end)
    end)
  end
end
