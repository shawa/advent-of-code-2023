defmodule Advent2023.Day02.Parser do
  alias Advent2023.Day02.Parser.Parsec

  alias Advent2023.Day02.Handful
  alias Advent2023.Day02.Game

  @default_counts %{red: 0, blue: 0, green: 0}

  def parse!(line) do
    {:ok, result, _, _, _, _} = Parsec.game(line)
    to_game_struct(result)
  end

  def to_game_struct([{:id, [id]} | handfuls]) do
    %Game{
      id: id,
      handfuls:
        Enum.map(handfuls, fn {:handful, cube_counts} -> to_handful_struct(cube_counts) end)
    }
  end

  def to_handful_struct(cube_counts) do
    fields =
      Map.merge(@default_counts, Map.new(cube_counts))

    struct(Handful, fields)
  end
end
