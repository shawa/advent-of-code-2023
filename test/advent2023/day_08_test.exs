defmodule Advent2023.Day08Test do
  import Advent2023.Day08
  use ExUnit.Case

  describe "part_one/1" do
    test "solves the sample correctly" do
      run(:sample) |> dbg()
    end
  end
end
