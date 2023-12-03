defmodule Advent2023.Day02.Handful do
  @type t() :: %__MODULE__{
          red: non_neg_integer(),
          green: non_neg_integer(),
          blue: non_neg_integer()
        }

  @enforce_keys [:red, :green, :blue]
  defstruct @enforce_keys

  @spec power(t()) :: non_neg_integer()
  def power(%__MODULE__{red: red, green: green, blue: blue}) do
    red * green * blue
  end
end
