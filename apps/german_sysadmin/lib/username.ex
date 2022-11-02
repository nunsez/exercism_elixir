defmodule Username do
  @moduledoc """
  You are working as a system administrator for a big company in Munich, Germany.

  One of your responsibilities is managing email accounts.

  You have been hearing complaints from people saying they are unable to write emails to Mr. Müller.

  You quickly realize that most of the company uses an old email client that doesn't
  recognize `müller@firma.de` as a valid email address because of the non-Latin character.

  Telling people to give up their favorite old email client is a lost battle,
  so you decide to create sanitized aliases for all email accounts.

  Tasks:

  1. Sanitize existing usernames by removing everything but lowercase letters
  2. Allow underscores
  3. Substitute German characters
  """

  @spec sanitize(charlist()) :: charlist()
  def sanitize(''), do: ''

  def sanitize([head | tail]) do
    sanitized =
      case head do
        head when head in ?a..?z -> [head]
        ?_ -> '_'
        ?ä -> 'ae'
        ?ö -> 'oe'
        ?ü -> 'ue'
        ?ß -> 'ss'
        _ -> ''
      end

    sanitized ++ sanitize(tail)
  end
end
