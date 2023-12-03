defmodule Advent2023.Day02.Parser.Helpers do
  import NimbleParsec

  def to_keyword_list(rest, args, context, _line, _offset) do
    keyword_list =
      args
      |> Enum.chunk_every(2)
      |> Enum.map(fn [key, value] -> {key, value} end)

    {rest, keyword_list, context}
  end

  def handful do
    empty()
    |> repeat(
      cube_count()
      |> ignore(string(", "))
    )
    |> concat(cube_count())
    |> post_traverse({__MODULE__, :to_keyword_list, []})
    |> tag(:handful)
  end

  defp cube_count() do
    empty()
    |> integer(min: 1)
    |> ignore(string(" "))
    |> concat(
      choice(Enum.map(~w(red green blue), &string/1))
      |> map({String, :to_existing_atom, []})
    )
  end
end
