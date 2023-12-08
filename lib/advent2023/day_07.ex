defmodule Advent2023.Day07 do
  def part_one(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.sort_by(fn {hand, _wager} -> classify_hand(hand) end)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_hand, wager}, i} -> wager * i end)
    |> Enum.sum()
  end

  def part_two(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.map(&find_most_jacked_hand/1)
    |> Enum.sort_by(&most_jacked/1)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_, wager}, i} -> wager * i end)
    |> Enum.sum()
  end

  def parse_line(line) do
    [hand_part, bid_part] =
      line
      |> String.split(" ")

    {bid, ""} = Integer.parse(bid_part)
    hand = String.to_charlist(hand_part)

    {hand, bid}
  end

  def parse_hand(hand_part) do
    hand_part
    |> String.to_charlist()
    |> Enum.map(&rank_card/1)
  end

  def rank_card(card, opts \\ [jacks: :high]) do
    jack =
      case Keyword.fetch!(opts, :jacks) do
        :high -> 11
        :low -> 1
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

  def most_jacked(
        {{{{{jacked_classification_rank, _jacked_classification_label}, _jacked_card_rankings},
           _jacked_hand},
          {{{_originaL_classification_rank, _oroginal_classification_label},
            original_card_rankings}, _original_hand}}, _wager}
      ) do
    {jacked_classification_rank, original_card_rankings}
  end

  def find_most_jacked_hand({hand, wager}) do
    jacked =
      hand
      |> generate_hands()
      |> Enum.map(
        &{
          classify_hand(&1, jacks: :low),
          &1
        }
      )
      |> Enum.sort()
      |> List.last()

    original =
      {classify_hand(hand), hand}

    {{jacked, original}, wager}
  end

  def generate_hands([a, b, c, d, e] = hand)
      when a != ?J and b != ?J and c != ?J and d != ?J and e != ?J do
    [hand]
  end

  def generate_hands(~c"JJJJJ"), do: [~c"AAAAA"]

  def generate_hands(hand) do
    jacks = Enum.filter(hand, &(&1 == ?J))
    non_jacks = Enum.reject(hand, &(&1 == ?J))

    replacement_card_groups =
      non_jacks
      |> MapSet.new()
      |> MapSet.to_list()
      |> replicate(Enum.count(jacks))
      |> cartesian_product()

    Enum.map(replacement_card_groups, fn replacements ->
      Enum.reduce(replacements, hand, fn replacement, acc ->
        replace_first(acc, ?J, replacement)
      end)
    end)
  end

  def cartesian_product([]), do: []

  def cartesian_product(lists) do
    lists
    |> Enum.reduce(&cartesian_product/2)
    |> List.flatten()
    |> Enum.chunk_every(Enum.count(lists))
  end

  def cartesian_product(set_a, set_b) do
    for a <- set_a, b <- set_b, do: [a, b]
  end

  def classify_hand(hand, opts \\ [jacks: :high]) do
    ranked_hand = Enum.map(hand, &rank_card(&1, opts))

    classification =
      ranked_hand
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.sort()
      |> classify_counts()

    {classification, ranked_hand}
  end

  def classify_counts(counts) do
    # return the counts here
    case counts do
      [5] -> {7, :five_of_kind}
      [1, 4] -> {6, :four_of_kind}
      [2, 3] -> {5, :full_house}
      [1, 1, 3] -> {4, :three_of_kind}
      [1, 2, 2] -> {3, :two_pair}
      [1, 1, 1, 2] -> {2, :one_pair}
      [1, 1, 1, 1, 1] -> {1, :high_card}
    end
  end

  def replicate(_, 0), do: []
  def replicate(x, 1), do: [x]
  def replicate(x, n), do: [x | replicate(x, n - 1)]
  def replace_first([], _x, _y), do: []
  def replace_first([x | xs], x, y), do: [y | xs]
  def replace_first([h | xs], x, y), do: [h | replace_first(xs, x, y)]
end
