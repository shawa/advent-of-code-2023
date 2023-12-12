defmodule Advent2023.Day12 do
  use Advent2023.Day, input: :lines

  alias Advent2023.Prolog

  @prolog_module "src/day_12.pl"

  def part_one(input) do
    Prolog.start_link(@prolog_module)

    input
    |> Enum.map(&parse/1)
    |> Enum.map(fn [pattern, spec] -> Prolog.solve(pattern, spec) end)
    |> Enum.sum()
    |> dbg()
  end

  def parse(input) do
    [pattern, list_contents] =
      String.split(input, " ")

    [inspect(pattern), "[#{list_contents}]"]
  end

  def repeat(_, 0), do: ""
  def repeat(s, n), do: s <> repeat(s, n - 1)

  def repeat_with(_, _, 0), do: ""
  def repeat_with(s, _, 1), do: s
  def repeat_with(s, char, n), do: s <> char <> repeat_with(s, char, n - 1)
end
