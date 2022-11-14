defmodule Newsletter do
  @moduledoc """
  You're a big model train enthusiast and have decided to share your passion
  with the world by starting a newsletter. You'll start by sending the first
  issue of your newsletter to your friends and acquaintances that share your
  hobby. You have a text file with a list of their email addresses.

  Tasks:

  1. Read email addresses from a file
  2. Open a log file for writing
  3. Log a sent email
  4. Close the log file
  5. Send the newsletter
  """

  @spec read_emails(Path.t()) :: [String.t()]
  def read_emails(path) do
    path
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  @spec open_log(Path.t()) :: pid()
  def open_log(path), do: File.open!(path, [:write])

  @spec log_sent_email(pid(), String.t()) :: :ok
  defdelegate log_sent_email(pid, email), to: IO, as: :puts

  @spec close_log(pid()) :: :ok | {:error, File.posix() | :badarg | :terminated}
  defdelegate close_log(pid), to: File, as: :close

  @spec send_newsletter(Path.t(), Path.t(), fun()) ::
    :ok | {:error, File.posix() | :badarg | :terminated}
  def send_newsletter(emails_path, log_path, send_fun) do
    log_pid = open_log(log_path)

    emails_path
    |> read_emails()
    |> Enum.each(fn(email) ->
      send_fun.(email) == :ok and log_sent_email(log_pid, email)
    end)

    close_log(log_pid)
  end
end
