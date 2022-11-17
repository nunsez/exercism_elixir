defmodule Plot do
  @moduledoc """
  Use the Plot struct as it is provided
  """

  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]

  @type t() :: %__MODULE__{}
end
