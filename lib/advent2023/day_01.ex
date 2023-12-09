defmodule Advent2023.Day01 do
  use Advent2023.Day, input: :lines

  alias Advent2023.Day01.Parser

  def part_one(lines), do: solve(lines, &Parser.parse_digits_simple!/1)
  def part_two(lines), do: solve(lines, &Parser.parse_spelled_digits!/1)

  defp solve(lines, parser) do
    lines
    |> Enum.map(parser)
    |> Enum.map(&number/1)
    |> Enum.sum()
  end

  defp number({first, last}) do
    first * 10 + last
  end
end
