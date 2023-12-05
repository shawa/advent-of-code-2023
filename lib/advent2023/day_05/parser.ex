defmodule Advent2023.Day05.Parser do
  alias Advent2023.Day05.Parser.Parsec
  alias Advent2023.Day05.Mapping
  alias Advent2023.Day05.RangeSpecification

  def parse!(input) do
    {:ok, ast, "", %{}, _, _} = Parsec.seeds(input)

    parse_input_from_ast(ast)
  end

  defp parse_input_from_ast([{:seeds, seeds} | rest]) do
    mappings =
      rest
      |> Enum.map(&parse_mapping_from_ast/1)
      |> Map.new(fn %{source: source} = mapping -> {source, mapping} end)

    %{seeds: seeds, mappings: mappings}
  end

  def parse_mapping_from_ast(
        {:map,
         [
           from_to: [from: [from], to: [to]],
           mappings: mappings
         ]}
      ) do
    #  def parse_mapping_from_ast({:map, [from_to: [from: [from], to: [to]]], mappings: mappings}) do
    ranges = Enum.map(mappings, &parse_range_from_ast/1)
    Mapping.new!(ranges, parse_category(from), parse_category(to))
  end

  def parse_range_from_ast({:mapping, [dest, source, width]}) do
    %RangeSpecification{
      source_number: source,
      destination_number: dest,
      width: width
    }
  end

  def parse_category("seed"), do: :seed
  def parse_category("soil"), do: :soil
  def parse_category("fertilizer"), do: :fertilizer
  def parse_category("water"), do: :water
  def parse_category("light"), do: :light
  def parse_category("temperature"), do: :temperature
  def parse_category("humidity"), do: :humidity
  def parse_category("location"), do: :location
end
