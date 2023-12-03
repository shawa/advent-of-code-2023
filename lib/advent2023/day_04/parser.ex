defmodule Advent2023.Day04.Parser do
  alias Advent2023.Day04.Parser.Parsec
  alias Advent2023.Day04.Card

  def parse!(line) do
    {:ok,
     [
       id: [id],
       winning_numbers: winning_numbers,
       my_numbers: my_numbers
     ], "", %{}, _, _} = Parsec.card(line)

    %Card{id: id, winning_numbers: winning_numbers, my_numbers: my_numbers}
  end
end
