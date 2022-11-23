defmodule LogParser do
  @moduledoc """
  After a recent security review you have been asked to clean up the
  organization's archived log files.

  Tasks:

  1. Identify garbled log lines
  2. Split the log line
  3. Remove artifacts from log
  4. Tag lines with user names
  """

  @valid_starts ["[DEBUG]", "[INFO]", "[WARNING]", "[ERROR]"]

  @spec valid_line?(String.t()) :: boolean()
  def valid_line?(line) do
    String.starts_with?(line, @valid_starts)
  end

  @spec split_line(String.t()) :: [String.t()]
  def split_line(line) do
    String.split(line, ~r/<[~*=-]*>/)
  end

  @spec remove_artifacts(String.t()) :: String.t()
  def remove_artifacts(line) do
    String.replace(line, ~r/end-of-line\d+/i, "")
  end

  @spec tag_with_user_name(String.t()) :: String.t()
  def tag_with_user_name(line) do
    case Regex.run(~r/User\s+(\S+)/, line) do
      [_, name | _] -> "[USER] #{name} #{line}"
      _ -> line
    end
  end
end
