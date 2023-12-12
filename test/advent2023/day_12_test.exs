defmodule Advent2023.Day12Test do
  use ExUnit.Case
  import Advent2023.Day12

  describe("run/0") do
    test "solves the input" do
      assert run() == [part_one: 7694]
    end
  end
end
