defmodule NameBadge do
  @moduledoc """
  In this exercise you'll be writing code to print name badges for factory employees.
  Employees have an ID, name, and department name.
  Employee badge labels are formatted as follows: `"[id] - name - DEPARTMENT"`.

  Tasks:

  1. Print a badge for an employee
  2. Print a badge for a new employee
  3. Print a badge for the owner
  """

  @spec print(integer() | nil, String.t(), String.t() | nil) :: String.t()
  def print(id, name, department) do
    dep = if department, do: String.upcase(department), else: "OWNER"

    if id do
      "[#{id}] - #{name} - #{dep}"
    else
      "#{name} - #{dep}"
    end
  end
end
