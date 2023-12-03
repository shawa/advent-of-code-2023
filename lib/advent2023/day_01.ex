defmodule Advent2023.Day01 do
  alias Advent2023.Day01.Parser

  @spec part_one([String.t()]) :: number()
  def part_one(lines), do: run!(lines, &Parser.parse_digits_simple!/1)

  @spec part_two([String.t()]) :: number()
  def part_two(lines), do: run!(lines, &Parser.parse_spelled_digits!/1)

  defp run!(lines, parser) do
    lines
    |> Enum.map(parser)
    |> Enum.map(&number_!/1)
    |> Enum.sum()
  end

  defp number_!({first, last}) do
    first * 10 + last
  end
end
