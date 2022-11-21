defmodule NewPassport do
  @moduledoc """
  Your passport is about to expire, so you need to drop by the city office to
  renew it. You know from previous experience that your city office is not
  necessarily the easiest to deal with, so you decide to do your best to always
  "focus on the happy path".

  You print out the form you need to get your new passport, fill it out, jump
  into your car, drive around the block, park and head to the office.

  All the following tasks will require implementing and extending
  `get_new_passport/3`.

  Tasks:

  1. Get into the building
  2. Go to the information desk and find which counter you should go to
  3. Go to the counter and get your form stamped
  4. Receive your new passport
  """

  @type manual() :: (Date.t() -> integer())

  @coffee_break_minutes 15

  @spec get_new_passport(NaiveDateTime.t(), Date.t(), atom()) ::
    {:ok, String.t()} | {:retry, NaiveDateTime.t()} | {:error, String.t()}
  def get_new_passport(now, birthday, form) do
    with {:ok, timestamp} <- enter_building(now),
          {:ok, manual} <- find_counter_information(now),
          counter <- manual.(birthday),
          {:ok, checksum} <- stamp_form(timestamp, counter, form) do
      {:ok, get_new_passport_number(timestamp, counter, checksum)}
    else
      {:coffee_break, _} -> {:retry, NaiveDateTime.add(now, @coffee_break_minutes, :minute)}
      error -> error
    end
  end

  # Do not modify the functions below

  @spec enter_building(NaiveDateTime.t()) :: {:ok, integer()} | {:error, String.t()}
  defp enter_building(%NaiveDateTime{} = datetime) do
    day = Date.day_of_week(datetime)
    time = NaiveDateTime.to_time(datetime)

    cond do
      day <= 4 and time_between(time, ~T[13:00:00], ~T[15:30:00]) ->
        {:ok, datetime |> DateTime.from_naive!("Etc/UTC") |> DateTime.to_unix()}

      day == 5 and time_between(time, ~T[13:00:00], ~T[14:30:00]) ->
        {:ok, datetime |> DateTime.from_naive!("Etc/UTC") |> DateTime.to_unix()}

      true ->
        {:error, "city office is closed"}
    end
  end

  @eighteen_years 18 * 365

  @spec find_counter_information(NaiveDateTime.t()) ::
    {:ok, manual()} | {:coffee_break, String.t()}
  defp find_counter_information(%NaiveDateTime{} = datetime) do
    time = NaiveDateTime.to_time(datetime)

    if time_between(time, ~T[14:00:00], ~T[14:20:00]) do
      {:coffee_break, "information counter staff on coffee break, come back in 15 minutes"}
    else
      {:ok, fn %Date{} = birthday -> 1 + div(Date.diff(datetime, birthday), @eighteen_years) end}
    end
  end

  @spec stamp_form(integer(), integer(), atom()) :: {:ok, integer()} | {:error, String.t()}
  defp stamp_form(timestamp, counter, :blue) when rem(counter, 2) == 1 do
    {:ok, 3 * (timestamp + counter) + 1}
  end

  defp stamp_form(timestamp, counter, :red) when rem(counter, 2) == 0 do
    {:ok, div(timestamp + counter, 2)}
  end

  defp stamp_form(_timestamp, _counter, _form), do: {:error, "wrong form color"}

  @spec get_new_passport_number(integer(), integer(), integer()) :: String.t()
  defp get_new_passport_number(timestamp, counter, checksum) do
    "#{timestamp}-#{counter}-#{checksum}"
  end

  @spec time_between(Time.t(), Time.t(), Time.t()) :: boolean()
  defp time_between(time, from, to) do
    Time.compare(from, time) != :gt and Time.compare(to, time) == :gt
  end
end
