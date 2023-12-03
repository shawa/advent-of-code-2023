defmodule Advent2023.Day04.ParsecTest do
  alias Advent2023.Day04.Parser.Parsec

  use ExUnit.Case

  describe "card/1" do
    test "parses a card correctly" do
      assert {:ok,
              [
                id: [1],
                winning_numbers: [41, 48, 83, 86, 17],
                my_numbers: [83, 86, 6, 31, 17, 9, 48, 53]
              ], "", %{}, {1, 0},
              48} ==
               Parsec.card("Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53")
    end
  end
end
