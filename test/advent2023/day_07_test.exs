defmodule Advent2023.Day07Test do
  alias Advent2023.Day07
  use ExUnit.Case

  @sample """
  32T3K 765
  T55J5 684
  KK677 28
  KTJJT 220
  QQQJA 483
  """
  describe "part_one/1" do
    test "solves the sample correctly" do
      solved =
        @sample
        |> String.trim()
        |> String.split("\n")
        |> Day07.part_one()

      assert solved == 6440
    end
  end
end
