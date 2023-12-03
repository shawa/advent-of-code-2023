defmodule Advent2023.Day04.Parser.Helpers do
  import NimbleParsec

  def whitespace(combinator) do
    combinator
    |> concat(ignore(repeat(string(" "))))
  end

  def numbers(combinator) do
    combinator
    |> concat(
      repeat(
        empty()
        |> integer(min: 1)
        |> whitespace()
      )
    )
  end
end
