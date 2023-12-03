defmodule Advent2023.Day01.Parser do
  alias Advent2023.Day01.Parser.Parsec

  def parse_spelled_digits!(line) do
    [first | _] = run_parser!(line, &Parsec.calibration_code/1)
    [last | _] = run_parser!(String.reverse(line), &Parsec.reverse_calibration_code/1)

    {first, last}
  end

  def parse_digits_simple!(line) do
    digits = run_parser!(line, &Parsec.simple_calibration_code/1)

    {
      List.first(digits),
      List.last(digits)
    }
  end

  defp run_parser!(string, parser) do
    {:ok, result, "", %{}, _, _} = parser.(string)
    result
  end
end
