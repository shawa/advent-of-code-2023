defmodule Advent2023.Helpers do
  @day_re ~r/Elixir.Advent2023.Day(?<day>\d{2})/

  def input_for(module), do: input_for(module, 1)
  @spec input_for(module(), 1 | 2 | :sample) :: String.t()
  def input_for(module, part) do
    filepath = input_filepath_for(module, part)

    filepath
    |> File.read!()
  end

  def input_lines_for(module), do: input_lines_for(module, 1)
  @spec input_lines_for(module, 1 | 2 | :sample) :: Stream.t()
  def input_lines_for(module, part) do
    filepath = input_filepath_for(module, part)

    filepath
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.into([])
  end

  defp input_filepath_for(module, part) do
    day = day_for(module)
    base_path = :code.priv_dir(:advent_2023)
    day_part = "day_#{day}"
    part_part = "part_#{part}.txt"

    Path.join([base_path, "input", day_part, part_part])
  end

  defp day_for(module) do
    module_string = Atom.to_string(module)
    captures = Regex.named_captures(@day_re, module_string)
    captures["day"]
  end
end
