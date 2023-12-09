defmodule Advent2023.Day05 do
  use Advent2023.Day, input: :binary

  alias Advent2023.Day05.Parser
  alias Advent2023.Day05.Mapping

  def part_one(input) do
    %{seeds: seeds, mappings: mappings} = Parser.parse!(input)

    seeds
    |> Enum.map(&map_seed(mappings, &1))
    |> Enum.min()
  end

  def map_seed(mappings, n) do
    map_seed(mappings, n, :seed)
  end

  def map_seed(_, n, :location) do
    n
  end

  def map_seed(mappings, n, source) do
    mapping = Map.fetch!(mappings, source)
    m = Mapping.map_number(mapping, n)
    map_seed(mappings, m, mapping.destination)
  end
end
