defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  @doc """
    Takes a string as an input and returnsa a Identicon.Image struct
    with the hex property turned into a list of numbers.
    Given the same input it will always return the same output.

  ## Example
      iex> Identicon.hash_input('bannana')
      %Identicon.Image{
      color: nil,
      hex: [158, 197, 170, 37, 92, 55, 209, 212, 165, 137, 106, 155, 190, 51, 35, 58]
      }
  """
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end


  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def mirror_row([first, second |  _tail] = row) do
    row ++ [second, first]
  end

  def build_grid(%Identicon.Image{hex: hex } = image) do
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror_row/1)
  end
end





