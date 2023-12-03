defmodule Advent2023.Day02.Parser.ParsecTest do
  alias Advent2023.Day02.Parser.Parsec

  use ExUnit.Case

  describe "handful/1" do
    test "parses a handful" do
      assert match?(
               {:ok, [handful: [blue: 3, red: 4]], _, _, _, _},
               Parsec.handful("3 blue, 4 red")
             )
    end
  end

  describe "game/1" do
    test "parses a game with one handul" do
      assert match?(
               {:ok,
                [
                  id: [1],
                  handful: [blue: 3, red: 4]
                ], _, _, _, _},
               Parsec.game("Game 1: 3 blue, 4 red")
             )
    end

    test "parses a game with many handfuls" do
      assert match?(
               {:ok,
                [
                  id: [4],
                  handful: [green: 1, red: 3, blue: 6],
                  handful: [green: 3, red: 6],
                  handful: [green: 3, blue: 15, red: 14]
                ], _, _, _, _},
               Parsec.game(
                 "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"
               )
             )
    end
  end
end
