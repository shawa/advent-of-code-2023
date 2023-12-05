defmodule Advent2023 do
  @moduledoc """
  Documentation for `Advent2023`.
  """

  alias Advent2023.Helpers

  @spec run!() :: :ok
  def run! do
    {:ok, all_modules} =
      :application.get_key(:advent_2023, :modules)

    all_modules
    |> Enum.map(&Atom.to_string/1)
    |> Enum.filter(&match?("Elixir.Advent2023.Day" <> <<_day::binary-size(2)>>, &1))
    |> Enum.map(&String.to_existing_atom/1)
    |> Enum.each(&run/1)
  end

  @spec run(module()) :: :ok
  def run(day) do
    input_lines = input_format_for(day).(day)

    part_1_result = day.part_one(input_lines)
    part_2_result = day.part_two(input_lines)

    IO.puts("""
    # #{inspect(day)}

    Part 1: #{part_1_result}
    Part 2: #{part_2_result}
    """)
  end

  def input_format_for(Advent2023.Day01), do: &Helpers.input_lines_for/1
  def input_format_for(Advent2023.Day02), do: &Helpers.input_lines_for/1
  def input_format_for(Advent2023.Day03), do: &Helpers.input_lines_for/1
  def input_format_for(Advent2023.Day04), do: &Helpers.input_lines_for/1
  def input_format_for(Advent2023.Day05), do: &Helpers.input_for/1
end
