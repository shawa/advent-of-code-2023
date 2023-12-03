defmodule Advent2023.Day02.ParserTest do
  alias Advent2023.Day02.Game
  alias Advent2023.Day02.Handful
  alias Advent2023.Day02.Parser

  use ExUnit.Case

  describe "parse!/1" do
    test "turns a line into a struct" do
      assert Parser.parse!(
               "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"
             ) ==
               %Game{
                 id: 4,
                 handfuls: [
                   %Handful{red: 3, green: 1, blue: 6},
                   %Handful{red: 6, green: 3, blue: 0},
                   %Handful{red: 14, green: 3, blue: 15}
                 ]
               }
    end
  end
end
