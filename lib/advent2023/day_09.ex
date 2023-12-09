defmodule Advent2023.Day09 do
  use Advent2023.Day, input: :lines

  def part_one(input), do: solve(input)
  def part_two(input), do: solve(input, :backwards)

  def solve(input, direction \\ :forwards) do
    {extrapolate_callback, reorder_callback} =
      case direction do
        :forwards ->
          {&extrapolate_forwards/2, &Function.identity/1}

        :backwards ->
          {&extrapolate_backwards/2,
           fn list_of_lists ->
             Enum.map(list_of_lists, &Enum.reverse/1)
           end}
      end

    input
    |> Enum.map(&parse_line/1)
    |> Enum.map(&run_differences/1)
    |> Enum.map(&run_extrapolation(&1, extrapolate_callback))
    |> Enum.map(reorder_callback)
    |> Enum.map(&List.last/1)
    |> Enum.map(&List.last/1)
    |> Enum.sum()
  end

  def parse_line(line) do
    line
    |> String.split(" ")
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn {x, ""} -> x end)
  end

  def naive_difference(numbers) do
    numbers
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.map(fn [l, r] -> r - l end)
  end

  def run_differences(numbers) do
    numbers
    |> Stream.iterate(&naive_difference/1)
    |> Stream.with_index()
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.take_while(fn [{prev, _i}, {_cur, _j}] -> has_pos_element?(prev) end)
    |> Stream.flat_map(fn
      [{prev, 0}, {cur, 1}] -> [prev, cur]
      [{_prev, _i}, {cur, _}] -> [cur]
    end)
    |> Enum.into([])
  end

  def extrapolate_forwards(upper, lower) do
    diff = List.last(lower) + List.last(upper)
    upper ++ [diff]
  end

  def extrapolate_backwards(upper, lower) do
    diff = List.first(upper) - List.first(lower)
    [diff | upper]
  end

  def run_extrapolation(lists, callback) do
    lists
    |> Enum.reverse()
    |> Enum.scan(callback)
  end

  def has_pos_element?(xs), do: Enum.any?(xs, &(&1 != 0))
end
