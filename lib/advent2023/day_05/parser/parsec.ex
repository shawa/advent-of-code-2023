defmodule Advent2023.Day05.Parser.Parsec do
  alias Advent2023.Day05.Parser.Combinators, as: C

  import NimbleParsec

  defparsec(
    :seeds,
    empty()
    |> ignore(string("seeds:"))
    |> C.whitespace()
    |> tag(empty() |> C.seed_list(), :seeds)
    |> C.vertical_whitespace()
    |> repeat(
      tag(
        empty()
        |> tag(empty() |> C.map_heading(), :from_to)
        |> ignore(C.whitespace(empty()))
        |> ignore(string("map:"))
        |> ignore(string("\n"))
        |> tag(
          repeat(
            empty()
            |> tag(empty() |> C.mapping_list(), :mapping)
            |> ignore(optional(string("\n")))
          ),
          :mappings
        ),
        :map
      )
      |> ignore(repeat(string("\n")))
    )
  )
end
