defmodule Advent2023.Day01.ParserTest do
  alias Advent2023.Day01.Parser

  use ExUnit.Case

  describe "parse_digits!/1" do
    test "handles sample input correctly" do
      assert Parser.parse_spelled_digits!("two1nine") == {2, 9}
      assert Parser.parse_spelled_digits!("eightwothree") == {8, 3}
      assert Parser.parse_spelled_digits!("abcone2threexyz") == {1, 3}
      assert Parser.parse_spelled_digits!("xtwone3four") == {2, 4}
      assert Parser.parse_spelled_digits!("4nineeightseven2") == {4, 2}
      assert Parser.parse_spelled_digits!("zoneight234") == {1, 4}
      assert Parser.parse_spelled_digits!("7pqrstsixteen") == {7, 6}
    end
  end
end
