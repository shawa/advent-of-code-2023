defmodule Advent2023.Day06Test do
  import Advent2023.Day06
  use ExUnit.Case

  describe "part_one/1" do
    test "solves part 1 and 2" do
      assert run() == [part_one: 2_344_708, part_two: 30_125_202]
    end
  end
end
