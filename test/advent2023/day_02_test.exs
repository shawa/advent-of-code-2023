defmodule Advent2023.Day02Test do
  use ExUnit.Case

  import Advent2023.Day02

  describe "run/0" do
    test "solves the input" do
      assert run() == [part_one: 2156, part_two: 66909]
    end
  end
end
