defmodule Advent2023.Day07 do
  use Advent2023.Day, input: :lines

  def part_one(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.map(fn {hand, bid} -> {Enum.map(hand, &rank_card(&1, jacks: :high)), bid} end)
    |> Enum.sort_by(&classify_hand(&1, jacks: :normal))
    |> Enum.with_index(1)
    |> Enum.map(fn {{_hand, wager}, i} -> wager * i end)
    |> Enum.sum()
  end

  def parse_line(line) do
    [hand_part, bid_part] =
      line
      |> String.split(" ")

    {bid, ""} = Integer.parse(bid_part)
    hand = parse_hand(hand_part)

    {hand, bid}
  end

  def part_two(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.map(fn {hand, bid} -> {Enum.map(hand, &rank_card(&1, jacks: :low)), bid} end)
    |> Enum.sort_by(&classify_hand(&1, jacks: :wildcard))
    |> Enum.with_index(1)
    |> Enum.map(fn {{_hand, wager}, i} -> wager * i end)
    |> Enum.sum()
  end

  def parse_hand(hand_part) do
    hand_part
    |> String.to_charlist()
  end

  def rank_card(card, jacks: jacks) do
    jack =
      case jacks do
        :low -> 1
        :high -> 11
      end

    case card do
      ?A -> 14
      ?K -> 13
      ?Q -> 12
      ?J -> jack
      ?T -> 10
      ?9 -> 9
      ?8 -> 8
      ?7 -> 7
      ?6 -> 6
      ?5 -> 5
      ?4 -> 4
      ?3 -> 3
      ?2 -> 2
    end
  end

  def classify_hand({ranked_hand, _bid}, jacks: jacks) do
    counts =
      ranked_hand
      |> Enum.frequencies()
      |> handle_wildcards(jacks)
      |> Map.values()
      |> Enum.sort()

    case counts do
      [5] -> {7, :five_of_kind, ranked_hand}
      [1, 4] -> {6, :four_of_kind, ranked_hand}
      [2, 3] -> {5, :full_house, ranked_hand}
      [1, 1, 3] -> {4, :three_of_kind, ranked_hand}
      [1, 2, 2] -> {3, :two_pair, ranked_hand}
      [1, 1, 1, 2] -> {2, :one_pair, ranked_hand}
      [1, 1, 1, 1, 1] -> {1, :high_card, ranked_hand}
    end
  end

  def handle_wildcards(frequencies, :normal), do: frequencies

  def handle_wildcards(frequencies, :wildcard) do
    most_frequent =
      frequencies |> Enum.max_by(fn {_, v} -> v end) |> elem(0)

    jack_frequency = Map.get(frequencies, ?J, 0)

    %{frequencies | most_frequent => frequencies[most_frequent] + jack_frequency}
    |> Map.delete(?J)
  end
end
