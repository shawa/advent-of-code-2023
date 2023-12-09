defmodule Advent2023.Day09Test do
  use ExUnit.Case

  import Advent2023.Day09

  describe "run/1" do
    test "solves the sample" do
      assert run(:sample) == [part_one: 114, part_two: 2]
    end

    test "solves the real thing" do
      assert run() == [{:part_one, 1887980197}, {:part_two, 990}]
    end
  end

  describe "naive_difference/1" do
    test "gets the pairwise difference" do
      xs = [0, 3, 6, 9, 12, 15]
      diff = naive_difference(xs)

      assert Enum.count(diff) == Enum.count(xs) - 1

      assert [3, 3, 3, 3, 3] == diff
    end
  end

  describe "extrapolate_forwards/3" do
    test "correctly extrapolates upper, from lower" do
      upper = [0, 3, 6, 9, 12, 15]
      lower = [3, 3, 3, 3, 3]

      extrapolate_forwards(upper, lower)
    end
  end
end
