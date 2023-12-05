defmodule Advent2023.Day05.RangeSpecification do
  @type t() :: %__MODULE__{
          source_number: non_neg_integer(),
          destination_number: non_neg_integer(),
          width: non_neg_integer()
        }
  @enforce_keys [:source_number, :destination_number, :width]

  defstruct @enforce_keys

  def map_to_destination(
        %__MODULE__{
          source_number: source_number,
          width: width,
          destination_number: destination_number
        },
        n
      )
      when n >= source_number and n <= source_number + width - 1 do
    destination_number +
      n - source_number
  end
end
