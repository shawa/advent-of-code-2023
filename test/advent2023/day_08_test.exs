defmodule Advent2023.Day08Test do
  import Advent2023.Day08
  use ExUnit.Case

  describe "part_one/1" do
    test "solves part one correctly" do
      assert run() == [part_one: 20221]
    end
  end
end
