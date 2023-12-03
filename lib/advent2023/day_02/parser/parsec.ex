defmodule Advent2023.Day02.Parser.Parsec do
  alias Advent2023.Day02.Parser.Helpers

  import NimbleParsec

  defparsec(
    :game,
    empty()
    |> ignore(string("Game"))
    |> ignore(string(" "))
    |> concat(
      integer(min: 1)
      |> tag(:id)
    )
    |> ignore(string(": "))
    |> repeat(
      Helpers.handful()
      |> ignore(string("; "))
    )
    |> concat(Helpers.handful())
  )

  defparsec(
    :handful,
    Helpers.handful()
  )
end
