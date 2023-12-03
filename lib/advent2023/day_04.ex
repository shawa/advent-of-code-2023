defmodule Advent2023.Day04 do
  alias Advent2023.Day04.Parser
  alias Advent2023.Day04.Card

  def part_one(input) do
    input
    |> cards!()
    |> Enum.map(&score/1)
    |> Enum.sum()
  end

  def part_two(input) do
    input
    |> cards!()
    |> count_winning_cards()
    |> Map.values()
    |> Enum.sum()
  end

  def score(card) do
    card
    |> Card.winning_numbers()
    |> then(fn
      0 -> 0
      count -> :math.pow(2, count - 1)
    end)
    |> trunc()
  end

  def count_winning_cards(cards) do
    Enum.reduce(cards, %{}, &generate_card_copies/2)
  end

  defp generate_card_copies(card, counts) do
    acc = Map.update(counts, card.id, 1, &(&1 + 1))

    case Card.winning_numbers(card) do
      0 ->
        acc

      n ->
        (card.id + 1)..(card.id + n)
        |> Map.new(&{&1, Map.fetch!(acc, card.id)})
        |> Map.merge(acc, fn _key, a, b -> a + b end)
    end
  end

  def cards!(input) do
    Enum.map(input, &Parser.parse!/1)
  end
end
