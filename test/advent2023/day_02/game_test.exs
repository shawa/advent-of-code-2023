defmodule Advent2023.Day02.GameTest do
  alias Advent2023.Day02.Game
  alias Advent2023.Day02.Parser
  alias Advent2023.Day02.Handful

  use ExUnit.Case

  describe "possible?/2" do
    test "marks a possible game as possible" do
      games = [
        "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
        "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
        "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
      ]

      configuration = %Handful{red: 12, green: 13, blue: 14}

      for game <- Enum.map(games, &Parser.parse!/1) do
        assert Game.possible?(game, configuration)
      end
    end

    test "marks a impossible game as impossible" do
      games = [
        "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
        "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"
      ]

      configuration = %Handful{red: 12, green: 13, blue: 14}

      for game <- Enum.map(games, &Parser.parse!/1) do
        refute Game.possible?(game, configuration)
      end
    end
  end
end
