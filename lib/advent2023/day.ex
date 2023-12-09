defmodule Advent2023.Day do
  defmacro __using__(opts) do
    input_format = Keyword.get(opts, :input)

    quote do
      def input(part_or_sample \\ 1) do
        unquote(
          if input_format == :lines do
            quote do
              Advent2023.Helpers.input_lines_for(__MODULE__, part_or_sample)
            end
          else
            quote do
              Advent2023.Helpers.input_for(__MODULE__, part_or_sample)
            end
          end
        )
      end

      def run() do
        format_atom =
          fn
            :part_one -> "Part 1"
            :part_two -> "Part 2"
          end

        mfas =
          [
            {__MODULE__, :part_one, 1},
            {__MODULE__, :part_two, 1}
          ]

        mfas
        |> Enum.filter(fn {module, function, arity} ->
          function_exported?(module, function, arity)
        end)
        |> Enum.map(fn {module, function, _arity} ->
          {function, apply(module, function, [input()])}
        end)
      end
    end
  end
end
