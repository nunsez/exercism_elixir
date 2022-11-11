defmodule FileSniffer do
  @moduledoc """
  You have been working on a project which allows users to upload files to the
  server to be shared with other users. You have been tasked with writing a
  function to verify that an upload matches its [media type][mimetype].

  You do some research and discover that the first few bytes of a file are
  generally unique to that file type, giving it a sort of signature.

  Use the following table for reference:

  | File type | Common extension | Media type                   | binary 'signature'                               |
  | --------- | ---------------- | ---------------------------- | ------------------------------------------------ |
  | ELF       | `"exe"`          | `"application/octet-stream"` | `0x7F, 0x45, 0x4C, 0x46`                         |
  | BMP       | `"bmp"`          | `"image/bmp"`                | `0x42, 0x4D`                                     |
  | PNG       | `"png"`          | `"image/png"`                | `0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A` |
  | JPG       | `"jpg"`          | `"image/jpg"`                | `0xFF, 0xD8, 0xFF`                               |
  | GIF       | `"gif"`          | `"image/gif"`                | `0x47, 0x49, 0x46`                               |

  Tasks:

  1. Given an extension, return the expected media type
  2. Given a binary file, return the expected media type
  3. Given an extension and a binary file, verify that the file matches the expected type
  """

  @format_mismatch_warning_message "Warning, file format and file extension do not match."

  @spec type_from_extension(String.t()) :: String.t() | nil
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
      _ -> nil
    end
  end

  @spec type_from_binary(binary()) :: String.t()
  def type_from_binary(file_binary) do
    case file_binary do
      <<0x7F, 0x45, 0x4C, 0x46, _::binary>> -> "application/octet-stream"
      <<0x42, 0x4D, _::binary>> -> "image/bmp"
      <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>> -> "image/png"
      <<0xFF, 0xD8, 0xFF, _::binary>> -> "image/jpg"
      <<0x47, 0x49, 0x46, _::binary>> -> "image/gif"
      _ -> nil
    end

  end

  @spec verify(binary(), String.t()) :: {:ok | :error, String.t()}
  def verify(file_binary, extension) do
    binary_type = type_from_binary(file_binary)
    ext_type = type_from_extension(extension)

    cond do
      binary_type === ext_type -> {:ok, binary_type}
      true -> {:error, @format_mismatch_warning_message}
    end
  end
end
