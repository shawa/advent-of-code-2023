defmodule Advent2023.Day05Test do
  import Advent2023.Day05

  use ExUnit.Case

  describe "run" do
    test "solves part 1" do
      assert run() == [part_one: 836_040_384]
    end
  end
end
