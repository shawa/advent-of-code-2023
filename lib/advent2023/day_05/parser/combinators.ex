defmodule Advent2023.Day05.Parser.Combinators do
  import NimbleParsec

  def whitespace(combinator) do
    combinator
    |> concat(ignore(repeat(string(" "))))
  end

  def vertical_whitespace(combinator) do
    combinator
    |> concat(ignore(repeat(string("\n"))))
  end

  def seed_list(combinator) do
    combinator
    |> concat(
      times(
        empty()
        |> integer(min: 1)
        |> whitespace(),
        min: 1
      )
    )
  end

  def mapping_list(combinator) do
    combinator
    |> concat(
      times(
        empty()
        |> integer(min: 1)
        |> whitespace(),
        3
      )
    )
  end

  def map_heading(combinator) do
    combinator
    |> tag(empty() |> map_heading_member(), :from)
    |> ignore(string("-to-"))
    |> tag(empty() |> map_heading_member(), :to)
  end

  def map_heading_member(combinator) do
    combinator
    |> concat(
      choice(
        Enum.map(
          ~w(seed soil fertilizer water light temperature humidity location),
          &string/1
        )
      )
    )
  end
end
