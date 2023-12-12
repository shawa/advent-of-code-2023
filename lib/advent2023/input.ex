defmodule Advent2023.Input do
  def input_for(module, input_or_sample \\ :input) do
    module
    |> input_filepath_for(input_or_sample)
    |> File.read!()
  end

  def input_lines_for(module, input_or_sample \\ :input) do
    module
    |> input_for(input_or_sample)
    |> String.trim()
    |> String.split("\n")
  end

  def input_charlists_for(module, input_or_sample \\ :input) do
    module
    |> input_lines_for(input_or_sample)
    |> Enum.map(&String.to_charlist/1)
  end

  def stringly_inspect(charlists) do
    charlists
    |> Enum.map(&List.to_string/1)
    |> Enum.join("\n")
    |> then(&IO.puts(&1 <> "\n"))

    charlists
  end

  defp input_filepath_for(module, part) do
    Path.join([
      :code.priv_dir(:advent_2023),
      "input",
      day_for(module),
      "#{part}.txt"
    ])
  end

  defp day_for(module) do
    <<"Elixir.Advent2023.Day", day::binary-size(2)>> = Atom.to_string(module)
    day
  end
end
