defmodule Advent2023.Day01.Parser.Helpers do
  import NimbleParsec

  @number_words ~w(one two three four five six seven eight nine)
  @reversed_number_words Enum.map(@number_words, &String.reverse/1)

  def spelled_number, do: a_word(@number_words)
  def reverse_spelled_number, do: a_word(@reversed_number_words)

  def calibration_code(word_combinator) do
    repeat(
      choice([
        word_combinator |> map({__MODULE__, :to_digit, []}),
        integer(1),
        ignore(ascii_char([?a..?z]))
      ])
    )
  end

  def simple_calibration_code() do
    repeat(
      choice([
        integer(1),
        ignore(ascii_char([?a..?z]))
      ])
    )
  end

  defp a_word(words) do
    choice(Enum.map(words, &string/1))
  end

  for {{word, reversed}, i} <-
        Enum.with_index(Enum.zip(@number_words, @reversed_number_words), 1) do
    def to_digit(unquote(word)), do: unquote(i)
    def to_digit(unquote(reversed)), do: unquote(i)
  end
end
