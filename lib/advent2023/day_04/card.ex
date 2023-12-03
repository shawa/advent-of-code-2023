defmodule Advent2023.Day04.Card do
  @type t() :: %__MODULE__{
          id: non_neg_integer(),
          winning_numbers: [non_neg_integer()],
          my_numbers: [non_neg_integer()]
        }

  @enforce_keys [:id, :winning_numbers, :my_numbers]
  defstruct @enforce_keys

  @spec winning_numbers(Advent2023.Day04.Card.t()) :: non_neg_integer()
  def winning_numbers(%__MODULE__{winning_numbers: winning, my_numbers: my_numbers}) do
    MapSet.size(
      MapSet.intersection(
        MapSet.new(winning),
        MapSet.new(my_numbers)
      )
    )
  end
end
