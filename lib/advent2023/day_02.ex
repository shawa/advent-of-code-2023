defmodule Advent2023.Day02 do
  alias Advent2023.Day02.Game
  alias Advent2023.Day02.Handful
  alias Advent2023.Day02.Parser

  @spec part_one([String.t()]) :: number()
  def part_one(lines) do
    configuration = %Handful{red: 12, green: 13, blue: 14}

    lines
    |> Enum.map(&Parser.parse!/1)
    |> Enum.filter(&Game.possible?(&1, configuration))
    |> Enum.map(fn %{id: id} -> id end)
    |> Enum.sum()
  end

  @spec part_two([String.t()]) :: number()
  def part_two(lines) do
    lines
    |> Enum.map(&Parser.parse!/1)
    |> Enum.map(&Game.minimal_handful/1)
    |> Enum.map(&Handful.power/1)
    |> Enum.sum()
  end
end
