defmodule Advent2023 do
  @moduledoc """
  Documentation for `Advent2023`.
  """

  def run() do
    {:ok, all_modules} =
      :application.get_key(:advent_2023, :modules)

    all_modules
    |> Enum.filter(fn module ->
      match?(<<"Elixir.Advent2023.Day", _::binary-size(2)>>, Atom.to_string(module))
    end)
    |> Enum.map(&{&1, apply(&1, :run, [])})
  end
end
