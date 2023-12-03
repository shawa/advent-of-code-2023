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
    input_lines = Helpers.input_lines_for(day)

    part_1_result = day.part_one(input_lines)
    part_2_result = day.part_two(input_lines)

    IO.puts("""
    # #{inspect(day)}

    Part 1: #{part_1_result}
    Part 2: #{part_2_result}
    """)
  end
end
