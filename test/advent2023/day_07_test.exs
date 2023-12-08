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
      # solved =
      #   @sample
      #   |> String.trim()
      #   |> String.split("\n")
      #   |> Day07.part_one()

      # # assert solved == 6440
    end
  end

  describe "cartesian_product/1" do
    test "returns the cartesian product of the lists in the list" do
      assert Day07.cartesian_product([[1, 2], [1, 2], [1, 2]]) ==
               [
                 [1, 1, 1],
                 [1, 1, 2],
                 [1, 2, 1],
                 [1, 2, 2],
                 [2, 1, 1],
                 [2, 1, 2],
                 [2, 2, 1],
                 [2, 2, 2]
               ]
    end
  end

  describe "cartesian_product/2" do
    test "returns the cartesian product of the 2 lists" do
      product_1 = [[1, 1], [1, 2], [2, 1], [2, 2]]
      assert Day07.cartesian_product([1, 2], [1, 2]) == product_1
    end
  end
end
