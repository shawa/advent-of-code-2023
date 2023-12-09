defmodule Advent2023.Day07Test do
  import Advent2023.Day07
  use ExUnit.Case

  describe "part_one/1" do
    test "solves the sample correctly" do
      assert run(:sample) == [part_one: 6440, part_two: 5905]
    end

    test "solves part 1 and two " do
      assert match?([{:part_one, 252_656_917} | t], run())
    end
  end
end
