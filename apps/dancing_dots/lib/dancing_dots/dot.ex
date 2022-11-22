defmodule DancingDots.Dot do
  @moduledoc false

  defstruct [:x, :y, :radius, :opacity]

  @type t :: %__MODULE__{}
end
