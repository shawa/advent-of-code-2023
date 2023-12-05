defmodule Advent2023.Day05.Mapping do
  alias Advent2023.Day05.RangeSpecification

  @type t() :: %__MODULE__{
          source: category(),
          destination: category(),
          tree: :gb_trees.tree()
        }

  @type category() :: :seed | :soil | :fertilizer | :water | :light | :temperature | :humidity

  @enforce_keys [
    :source,
    :destination,
    :tree
  ]

  defstruct @enforce_keys

  @spec new!([RangeSpecification.t()], category(), category()) :: %__MODULE__{}
  def new!(ranges, source, destination) when source != destination do
    %__MODULE__{
      source: source,
      destination: destination,
      tree: build_gb_tree(ranges)
    }
  end

  def build_gb_tree(ranges) do
    ranges
    |> Enum.flat_map(fn range ->
      [
        {range.source_number, {:first, range}},
        {range.source_number + range.width - 1, {:last, range}}
      ]
    end)
    |> Enum.reduce(:gb_trees.empty(), fn {key, value}, tree ->
      :gb_trees.enter(
        key,
        value,
        tree
      )
    end)
  end

  def map_number(%__MODULE__{tree: tree}, n) do
    case lookup(tree, n) do
      nil ->
        n

      range ->
        range
        |> RangeSpecification.map_to_destination(n)
    end
  end

  defp lookup(tree, n) do
    iterator = :gb_trees.iterator_from(n, tree)

    case :gb_trees.next(iterator) do
      {k, {:first, _range}, _} when n < k -> nil
      {k, {:first, range}, _} when n == k -> range
      {k, {:last, _range}, _} when n > k -> nil
      {k, {:last, range}, _} when n <= k -> range
      :none -> nil
    end
  end
end
