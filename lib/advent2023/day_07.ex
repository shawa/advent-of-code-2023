defmodule Advent2023.Day07 do
  def part_one(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.sort_by(&classify_hand/1)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_hand, wager}, i} -> wager * i end)
    |> Enum.sum()
  end

  def part_two(input), do: part_one(input)

  def parse_line(line) do
    [hand_part, bid_part] =
      line
      |> String.split(" ")

    {bid, ""} = Integer.parse(bid_part)
    hand = parse_hand(hand_part)

    {hand, bid}
  end

  def parse_hand(hand_part) do
    hand_part
    |> String.to_charlist()
    |> Enum.map(&rank_card/1)
  end

  def rank_card(card) do
    case card do
      ?A -> 14
      ?K -> 13
      ?Q -> 12
      ?J -> 11
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

  def classify_hand({ranked_hand, _bid}) do
    counts =
      ranked_hand
      |> Enum.frequencies()
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
end
