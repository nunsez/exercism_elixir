defmodule LibraryFees do
  @moduledoc """
  Your librarian friend has asked you to extend her library software to
  automatically calculate late fees. Her current system stores the exact date and
  time of a book checkout as an ISO8601 datetime string. She runs a local library
  in a small town in Ghana, which uses the GMT timezone (UTC +0), doesn't use
  daylight saving time, and doesn't need to worry about other timezones.

  Tasks:

  1. Parse the stored datetimes
  2. Determine if a book was checked out before noon
  3. Calculate the return date
  4. Determine how late the return of the book was
  5. Determine if the book was returned on a Monday
  6. Calculate the late fee
  """

  @monday_fee_offer 0.5

  @spec datetime_from_string(String.t()) :: NaiveDateTime.t()
  defdelegate datetime_from_string(string), to: NaiveDateTime, as: :from_iso8601!

  @spec before_noon?(NaiveDateTime.t()) :: boolean()
  def before_noon?(datetime), do: datetime.hour < 12

  @spec return_date(NaiveDateTime.t()) :: Date.t()
  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29

    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(days)
  end

  @spec days_late(Date.t(), NaiveDateTime.t()) :: non_neg_integer()
  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  @spec monday?(NaiveDateTime.t()) :: boolean()
  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week(:monday)
    |> Kernel.==(1)
  end

  @spec calculate_late_fee(String.t(), String.t(), non_neg_integer()) :: non_neg_integer()
  def calculate_late_fee(checkout, return, rate) do
    return_datetime = datetime_from_string(return)
    checkout_datetime = datetime_from_string(checkout)

    raw_fee =
      checkout_datetime
      |> return_date()
      |> days_late(return_datetime)
      |> Kernel.*(rate)

    cond do
      monday?(return_datetime) -> floor(raw_fee * @monday_fee_offer)
      true -> raw_fee
    end
  end
end
