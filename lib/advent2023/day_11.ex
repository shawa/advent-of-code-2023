defmodule Advent2023.Day11 do
  use Advent2023.Day, input: :charlists

  def part_one(input) do
    input
    |> expand()
    |> index_and_parse()
    |> Enum.filter(&match?({_coord, ?#}, &1))
    |> Enum.map(fn {coord, _} -> coord end)
    |> pairs_unique()
    |> Enum.map(fn [p1, p2] -> taxicab(p1, p2) end)
    |> Enum.sum()
  end

  def expand(input) do
    input
    |> expand_rows()
    |> transpose()
    |> expand_rows()
    |> transpose()
  end

  def expand_rows(input) do
    input
    |> Enum.reduce([], fn row, acc ->
      if Enum.all?(row, &(&1 == ?.)) do
        [row, row | acc]
      else
        [row | acc]
      end
    end)
  end

  def index_and_parse(charlists) do
    charlists
    |> Enum.with_index()
    |> Enum.flat_map(fn {charlist, i} ->
      charlist
      |> Enum.with_index()
      |> Enum.map(fn {point, j} -> {{i, j}, point} end)
    end)
  end

  def pairs_unique(list) do
    list
    |> Enum.with_index()
    |> Enum.flat_map(fn {elem, idx} ->
      Enum.drop(list, idx + 1)
      |> Enum.map(&[elem, &1])
    end)
  end

  def transpose(lists) do
    lists
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  def taxicab({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)

  def repeat(_, 0), do: []
  def repeat(x, n), do: [x | repeat(x, n - 1)]

  def inflate(coord_line) do
    coord_line
    |> Enum.with_index()
    |> Enum.map(fn {_, i} -> i end)
    |> Enum.chunk_by(2, 1, :discard)
  end

  def coord_line(charlists, :x), do: zip_or(charlists)

  def coord_line(charlists, :y) do
    charlists
    |> transpose()
    |> coord_line(:x)
  end

  def zip_or(charlists) do
    charlists
    |> Enum.zip_with(fn xs ->
      if Enum.any?(xs, &(&1 == ?#)) do
        ?#
      else
        ?.
      end
    end)
  end
end
