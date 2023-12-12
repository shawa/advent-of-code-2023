defmodule Advent2023.Day11Test do
  use ExUnit.Case
  import Advent2023.Day11

  describe("run/0") do
    test "solves the sample" do
      assert run(:sample) == [part_one: 374]
    end
  end

  describe "coord_line/2" do
    test "collapses a list of rows into one row" do
      rows = [
        ~c"#..",
        ~c"..#",
        ~c"..."
      ]

      assert coord_line(rows, :x) == ~c"#.#"
      assert coord_line(rows, :y) == ~c"##."
    end
  end

  describe "inflate/2" do
    # test "inflates the distances between a list of points" do
    #   assert inflate([0, 2]) == [0, 1_000_000 + 2]
    #   assert inflate([0, 2, 5]) == [0, 1_000_000 + 2]
    # end
  end
end
