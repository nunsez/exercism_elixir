defmodule TopSecret do
  @moduledoc """
  You're part of a task force fighting against corporate espionage. You have a
  secret informer at Shady Company X, which you suspect of stealing secrets from
  its competitors.

  Your informer, Agent Ex, is an Elixir developer. She is encoding secret
  messages in her code.

  To decode her secret messages:

  - Take all functions (public and private) in the order they're defined
  in.
  - For each function, take the first `n` characters from its name, where `n`
  is the function's arity.

  Tasks:

  1. Turn code into data
  2. Parse a single AST node
  3. Decode the secret message part from function definition
  4. Fix the decoding for functions with guards
  5. Decode the full secret message
  """

  defguardp is_secret_token(token) when token in [:def, :defp]

  @spec to_ast(String.t()) :: Macro.t()
  defdelegate to_ast(string), to: Code, as: :string_to_quoted!

  @spec decode_secret_message_part(Macro.t(), [String.t()]) :: {Macro.t(), [String.t()]}
  def decode_secret_message_part({token, _, children} = ast, acc)
  when is_secret_token(token) do
    secret =
      children
      |> List.first()
      |> to_secret()

    {ast, [secret | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  @spec decode_secret_message(String.t()) :: String.t()
  def decode_secret_message(string) do
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> List.to_string
  end

  @spec to_secret(Macro.t()) :: String.t()
  defp to_secret({_, _, nil}), do: ""

  defp to_secret({:when, _, children}) do
    children
    |> List.first()
    |> to_secret()
  end

  defp to_secret({token, _, children}) do
    token
    |> Atom.to_string()
    |> String.slice(0, length(children))
  end
end
