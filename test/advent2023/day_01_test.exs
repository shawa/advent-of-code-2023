defmodule Advent2023.Day01Test do
  use ExUnit.Case

  import Advent2023.Day01

  describe "run/0" do
    test "solves the input" do
      assert run() == [part_one: 55607, part_two: 55291]
    end
  end
end
