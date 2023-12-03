defmodule Advent2023.Day04.Parser.Parsec do
  alias Advent2023.Day04.Parser.Helpers
  import NimbleParsec

  defparsec(
    :card,
    empty()
    |> ignore(string("Card"))
    |> Helpers.whitespace()
    |> tag(integer(min: 1), :id)
    |> ignore(string(":"))
    |> Helpers.whitespace()
    |> tag(empty() |> Helpers.numbers(), :winning_numbers)
    |> ignore(string("|"))
    |> Helpers.whitespace()
    |> tag(empty() |> Helpers.numbers(), :my_numbers)
  )
end
