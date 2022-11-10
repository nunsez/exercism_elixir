defmodule WineCellar do
  @moduledoc """
  You are the manager of a fancy restaurant that has a sizable wine cellar.
  A lot of your customers are demanding wine enthusiasts.
  Finding the right bottle of wine for a particular customer is not an easy task.

  As a tech-savvy restaurant owner, you decided to speed up the wine selection
  process by writing an app that will let guests filter your wines by their preferences.

  Tasks:

  1. Explain wine colors
  2. Get all wines of a given color
  3. Get all wines of a given color bottled in a given year
  4. Get all wines of a given color bottled in a given country
  """

  @type wine() :: {String.t(), non_neg_integer(), String.t()}

  @spec explain_colors :: keyword()
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  @spec filter(keyword(), String.t(), keyword()) :: [wine()]
  def filter(cellar, color, opts \\ []) do
    cellar
    |> Keyword.get_values(color)
    |> filter_by_year(opts[:year])
    |> filter_by_country(opts[:country])
  end

  # The functions below do not need to be modified.

  @spec filter_by_year([wine()], non_neg_integer() | nil) :: [wine()]
  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []
  defp filter_by_year(wines, nil), do: wines

  defp filter_by_year([{_, year, _} = wine | tail], year) do
    [wine | filter_by_year(tail, year)]
  end

  defp filter_by_year([{_, _, _} | tail], year) do
    filter_by_year(tail, year)
  end

  @spec filter_by_country([wine()], String.t() | nil) :: [wine()]
  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []
  defp filter_by_country(wines, nil), do: wines

  defp filter_by_country([{_, _, country} = wine | tail], country) do
    [wine | filter_by_country(tail, country)]
  end

  defp filter_by_country([{_, _, _} | tail], country) do
    filter_by_country(tail, country)
  end
end
