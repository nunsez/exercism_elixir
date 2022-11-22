defmodule DancingDots.Flicker do
  @moduledoc false

  use DancingDots.Animation

  @impl DancingDots.Animation
  def handle_frame(dot, 1, _), do: dot

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _) when rem(frame_number, 4) == 0 do
    %{dot | opacity: dot.opacity / 2}
  end

  @impl DancingDots.Animation
  def handle_frame(dot, _, _), do: dot
end
