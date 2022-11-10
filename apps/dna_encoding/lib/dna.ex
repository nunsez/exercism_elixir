defmodule DNA do
  @moduledoc """
  In your DNA research lab, you have been working through various ways to
  compress your research data to save storage space.
  One teammate suggests converting the DNA data to a binary representation:

  | Nucleic Acid | Code   |
  | ------------ | ------ |
  | a space      | `0000` |
  | A            | `0001` |
  | C            | `0010` |
  | G            | `0100` |
  | T            | `1000` |

  You ponder this, as it will potentially halve the required data storage costs,
  but at the expense of human readability. You decide to write a module to
  encode and decode your data to benchmark your savings.

  Tasks:

  1. Encode nucleic acid to binary value
  2. Decode the binary value to the nucleic acid
  3. Encode a DNA charlist
  4. Decode a DNA bitstring
  """

  @type nucleotide() :: ?\s | ?A | ?C | ?G | ?T
  @type nucleotide_code() :: 0b0000..0b1000
  @type dna() :: [nucleotide()]

  @spec encode_nucleotide(nucleotide()) :: nucleotide_code()
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  @spec decode_nucleotide(nucleotide_code()) :: nucleotide()
  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  @spec encode(dna()) :: bitstring()
  def encode(''), do: <<>>
  def encode([value | rest]), do: <<encode_nucleotide(value)::size(4), encode(rest)::bitstring>>

  @spec decode(bitstring()) :: dna()
  def decode(<<>>), do: []
  def decode(<<value::size(4), rest::bitstring>>), do: [decode_nucleotide(value) | decode(rest)]
end
