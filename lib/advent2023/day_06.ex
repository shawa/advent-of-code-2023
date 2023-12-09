defmodule Advent2023.Day06 do
  use Advent2023.Day, input: :lines

  @input_1 [{44, 277}, {89, 1136}, {96, 1890}, {91, 1768}]
  @input_2 [{44_899_691, 277_113_618_901_768}]

  def part_one(input) do
    input
    |> parse()
    |> solve()
  end

  def part_two(input) do
    input
    |> parse(:none)
    |> solve()
  end

  def parse(races, kerning \\ :normal) do
    [times, distances] =
      Enum.map(races, &parse_numbers(&1, kerning))

    Enum.zip(times, distances)
  end

  def parse_numbers(number_string, kerning) do
    number_string
    |> String.split(~r/\s+/)
    |> then(fn [_label | rest] ->
      number_strings =
        case kerning do
          :normal -> rest
          :none -> rest |> Enum.join("") |> List.wrap()
        end

      Enum.map(number_strings, &Integer.parse/1)
    end)
    |> Enum.map(fn {x, ""} -> x end)
  end

  def solve(inputs) do
    inputs
    |> Enum.map(&roots/1)
    |> Enum.map(fn {hi, lo} -> floor(hi) - floor(lo) end)
    |> Enum.product()
  end

  def roots({t, s}) do
    {
      (t + :math.sqrt(t * t - 4 * s)) / 2,
      (t - :math.sqrt(t * t - 4 * s)) / 2
    }
  end
end
