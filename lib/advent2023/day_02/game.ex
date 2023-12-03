defmodule Advent2023.Day02.Game do
  alias Advent2023.Day02.Handful
  alias Advent2023.Day02.Game

  @type t() :: %__MODULE__{
          id: non_neg_integer(),
          handfuls: [Handful.t()]
        }

  @enforce_keys [:id, :handfuls]
  defstruct @enforce_keys

  @spec possible?(t(), Handful.t()) :: bool()
  def possible?(%__MODULE__{handfuls: handfuls}, %Handful{
        red: max_reds,
        green: max_greens,
        blue: max_blues
      }) do
    Enum.all?(
      handfuls,
      fn %{red: reds, green: greens, blue: blues} ->
        reds <= max_reds and
          greens <= max_greens and
          blues <= max_blues
      end
    )
  end

  @spec minimal_handful(t()) :: Handful.t()
  def minimal_handful(%Game{handfuls: handfuls}) do
    Enum.reduce(
      handfuls,
      %Handful{red: 0, green: 0, blue: 0},
      fn cur, acc ->
        %Handful{
          red: max(cur.red, acc.red),
          green: max(cur.green, acc.green),
          blue: max(cur.blue, acc.blue)
        }
      end
    )
  end
end
