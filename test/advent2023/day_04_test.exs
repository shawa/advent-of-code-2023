defmodule Advent2023.Day04Test do
  import Advent2023.Day04

  use ExUnit.Case

  describe "run" do
    test "solves part 1 and 2" do
      assert run() == [part_one: 21959, part_two: 5_132_675]
    end
  end
end
