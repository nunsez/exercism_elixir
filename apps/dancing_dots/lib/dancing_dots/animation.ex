defmodule DancingDots.Animation do
  @moduledoc false

  @type dot() :: DancingDots.Dot.t()
  @type opts() :: keyword()
  @type error() :: any()
  @type frame_number() :: pos_integer()

  @callback init(opts()) :: {:ok, opts()} | {:error, error()}

  @callback handle_frame(dot(), frame_number(), opts()) :: dot()

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation

      @impl DancingDots.Animation
      def init(opts), do: {:ok, opts}

      defoverridable init: 1
    end
  end
end
