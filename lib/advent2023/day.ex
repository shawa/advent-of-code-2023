defmodule Advent2023.Day do
  alias Advent2023.Input

  defmacro __using__(opts) do
    input_format = Keyword.get(opts, :input)

    quote do
      def input(input_or_sample \\ :input) do
        unquote(
          if input_format == :lines do
            quote do
              Input.input_lines_for(__MODULE__, input_or_sample)
            end
          else
            quote do
              Input.input_for(__MODULE__, input_or_sample)
            end
          end
        )
      end

      def run(input_or_sample \\ :input) do
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
          {function, apply(module, function, [input(input_or_sample)])}
        end)
      end
    end
  end
end
