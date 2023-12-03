defmodule Advent2023.Day01.Parser.Parsec do
  alias Advent2023.Day01.Parser.Helpers

  import NimbleParsec

  defparsec(
    :calibration_code,
    Helpers.calibration_code(Helpers.spelled_number())
  )

  defparsec(
    :reverse_calibration_code,
    Helpers.calibration_code(Helpers.reverse_spelled_number())
  )

  defparsec(
    :simple_calibration_code,
    Helpers.simple_calibration_code()
  )
end
