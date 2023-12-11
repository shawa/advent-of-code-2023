defmodule Mix.Tasks.Advent2023.New do
  use Mix.Task

  @module_template """
  defmodule Advent2023.Day<%= %> do

  end
  """

  def run([n]) do
    create_elixir_modules(n)
  end

  def run(_) do
    IO.puts("""
    Create a new solution, and test file

    Usage: mix advent2023.new <day>

    This will create
    lib
      advent2023
        day_<day>.ex

    test
      advent2023
        day_<day>_test.exs
    """)
  end

  def create_elixir_modules(str) do
    formatted = format_number(str)

    module_filepath = Path.join(["lib", "advent2023", "day_#{formatted}.ex"])
    test_module_filepath = Path.join(["test", "advent2023", "day_#{formatted}_test.exs"])
    input_dir_filepath = Path.join([:code.priv_dir(:advent_2023), "input", formatted])

    if Enum.any?([module_filepath, test_module_filepath, input_dir_filepath], &File.exists?/1) do
      IO.puts("File/dir(s) already exist; bailing.")
    end

    module = module_for(str) |> dbg()
    test_module = test_module_for(str) |> dbg()

    module_contents = advent_day(module)
    test_module_contents = advent_day_test(test_module, module)

    File.mkdir_p!(input_dir_filepath)
    File.touch(Path.join(input_dir_filepath, "sample.txt"))

    create_module(module_filepath, module_contents)
    create_module(test_module_filepath, test_module_contents)
  end

  def advent_day(module) do
    quote do
      defmodule unquote(module) do
        use Advent2023.Day, input: :lines

        def part_one(input) do
          Enum.count(input)
        end
      end
    end
  end

  def advent_day_test(module, module_under_test) do
    quote do
      defmodule unquote(module) do
        use ExUnit.Case
        import unquote(module_under_test)

        describe "run/0" do
          test "solves the sample" do
            run(:sample) |> dbg()
          end
        end
      end
    end
  end

  defp create_module(path, contents) do
    contents
    |> Macro.to_string()
    |> then(&File.write!(path, &1))
  end

  defp module_for(str) do
    String.to_atom("Elixir.Advent2023.Day#{str}")
  end

  defp test_module_for(str) do
    String.to_atom("Elixir.Advent2023.Day#{str}Test")
  end

  defp format_number(str) do
    str
    |> Integer.parse()
    |> then(fn {n, ""} -> n end)
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end
end
