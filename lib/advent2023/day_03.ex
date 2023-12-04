defmodule Advent2023.Day03 do
  import Nx.Defn

  @convolution_directions [
    :up,
    :up_right,
    :right,
    :down_right,
    :down,
    :down_left,
    :left,
    :up_left
  ]

  def part_one(input) do
    charlists = Enum.map(input, &String.to_charlist/1)
    schematic = Nx.tensor(charlists)

    symbols = extract_non_digits(schematic)
    digits = extract_digits(schematic)

    digits_adjacent_to_part =
      extract_adjacent_digit_mask(symbols, digits)

    {:ok, mask} = find_fixed_point(digits_adjacent_to_part, &fill_iteration(&1, digits))

    numbers = Nx.multiply(mask, digits) |> extract_numbers()

    Enum.sum(numbers)
  end

  defn extract_digits(t) do
    t *
      is_digit?(t)
  end

  defn extract_non_digits(t) do
    t *
      (not is_digit?(t) and t != ?.)
  end

  defn to_mask(t) do
    t > 0
  end

  defn is_digit?(t) do
    ?0 <= t and t <= ?9
  end

  def extract_numbers(t) do
    t
    |> Nx.to_list()
    |> Enum.flat_map(fn list ->
      Enum.chunk_by(list, &(&1 != 0))
      |> Enum.reject(fn list -> Enum.all?(list, &(&1 == 0)) end)
      |> Enum.map(&List.to_string/1)
      |> Enum.map(&to_integer!/1)
    end)
  end

  def fill_iteration(part_mask, digits) do
    spread_part_mask =
      Enum.reduce(
        [
          shift(part_mask, :left),
          part_mask,
          shift(part_mask, :right)
        ],
        &Nx.logical_or/2
      )

    to_mask(Nx.multiply(spread_part_mask, digits))
  end

  def find_fixed_point(value, f, max_iterations \\ 64) do
    cond do
      max_iterations == 0 ->
        {:error, :max_iterations_exceeded}

      f.(value) == value ->
        {:ok, value}

      true ->
        find_fixed_point(f.(value), f)
    end
  end

  def extract_adjacent_digit_mask(symbols, digits) do
    symbols
    |> to_mask()
    |> convolute()
    |> Nx.multiply(digits)
    |> to_mask()
  end

  def convolute(t) do
    @convolution_directions
    |> Enum.map(&shift(t, &1))
    |> Enum.reduce(&Nx.logical_or/2)
  end

  def shift(t, direction) do
    Nx.pad(t, 0, pad_config_for(direction))
  end

  def pad_config_for(:up), do: [{-1, 1, 0}, {0, 0, 0}]
  def pad_config_for(:up_right), do: [{-1, 1, 0}, {1, -1, 0}]
  def pad_config_for(:right), do: [{0, 0, 0}, {1, -1, 0}]
  def pad_config_for(:down_right), do: [{1, -1, 0}, {1, -1, 0}]
  def pad_config_for(:down), do: [{1, -1, 0}, {0, 0, 0}]
  def pad_config_for(:down_left), do: [{1, -1, 0}, {-1, 1, 0}]
  def pad_config_for(:left), do: [{0, 0, 0}, {-1, 1, 0}]
  def pad_config_for(:up_left), do: [{-1, 1, 0}, {-1, 1, 0}]

  def part_two(input), do: part_one(input)

  def stringly_inspect(t) do
    t
    |> Nx.to_list()
    |> Enum.map(fn list ->
      list
      |> Enum.map(fn
        0 -> ?.
        1 -> ?t
        x -> x
      end)
      |> List.to_string()
    end)
    |> Enum.join("\n")
    |> then(&IO.puts(&1 <> "\n"))

    t
  end

  defp to_integer!(str) do
    {integer, ""} = Integer.parse(str)
    integer
  end
end
