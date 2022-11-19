defmodule GermanSysadmin.Username do
  @moduledoc false

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
