defmodule Advent2023.Day06 do
  @input_1 [{44, 277}, {89, 1136}, {96, 1890}, {91, 1768}]
  @input_2 [{44_899_691, 277_113_618_901_768}]

  def part_one(_), do: solve(@input_1)
  def part_two(_), do: solve(@input_2)

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
