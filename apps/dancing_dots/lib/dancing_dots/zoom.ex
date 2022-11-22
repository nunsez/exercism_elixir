defmodule DancingDots.Zoom do
  @moduledoc false

  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    velocity = Keyword.get(opts, :velocity)

    cond do
      is_number(velocity) -> {:ok, opts}
      true -> {:error, init_error_message(velocity)}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, opts) do
    velocity = Keyword.get(opts, :velocity)
    new_radius = dot.radius + velocity * (frame_number - 1)

    %{dot | radius: new_radius}
  end

  @spec init_error_message(any()) :: String.t()
  defp init_error_message(velocity) do
    "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"
  end
end
