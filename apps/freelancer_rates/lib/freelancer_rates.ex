defmodule FreelancerRates do
  @moduledoc """
  In this exercise you'll be writing code to help a freelancer communicate
  with a project manager by providing a few utilities to quickly calculate
  daily and monthly rates, optionally with a given discount.

  We first establish a few rules between the freelancer
  and the project manager:

  The daily rate is 8 times the hourly rate.
  A month has 22 billable days.
  The freelancer is offering to apply a discount if the project manager
  chooses to let the freelancer bill per month, which can come in handy
  if there is a certain budget the project manager has to work with.

  Discounts are modeled as fractional numbers representing percentage,
  for example 25.0 (25%).

  Tasks:

  1. Calculate the daily rate given an hourly rate
  2. Calculate a discounted price
  3. Calculate the monthly rate, given an hourly rate and a discount
  4. Calculate the number of workdays given a budget,
      hourly rate and discount
  """

  @daily_rate 8.0
  @monthly_billable_days 22

  @spec daily_rate(integer()) :: float()
  def daily_rate(hourly_rate), do: hourly_rate * @daily_rate

  @spec apply_discount(integer(), integer()) :: float()
  def apply_discount(before_discount, discount) do
    before_discount * (100 - discount) / 100
  end

  @spec monthly_rate(integer(), float()) :: integer()
  def monthly_rate(hourly_rate, discount) do
    @monthly_billable_days * daily_discounted_rate(hourly_rate, discount)
    |> ceil
  end

  @spec days_in_budget(integer(), integer(), float()) :: float()
  def days_in_budget(budget, hourly_rate, discount) do
    budget / daily_discounted_rate(hourly_rate, discount)
    |> Float.floor(1)
  end

  @spec daily_discounted_rate(integer(), float()) :: float()
  defp daily_discounted_rate(hourly_rate, discount) do
    hourly_rate
    |> daily_rate
    |> apply_discount(discount)
  end
end
