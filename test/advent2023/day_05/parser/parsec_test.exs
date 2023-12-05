defmodule Advent2023.Day05.Parser.ParsecTest do
  use ExUnit.Case

  alias Advent2023.Day05.Parser.Parsec
  alias Advent2023.TestFixtures

  @example """
  seeds: 79 14 55 13

  seed-to-soil map:
  50 98 2
  52 50 48

  soil-to-fertilizer map:
  0 15 37
  37 52 2
  39 0 15

  fertilizer-to-water map:
  49 53 8
  0 11 42
  42 0 7
  57 7 4

  water-to-light map:
  88 18 7
  18 25 70

  light-to-temperature map:
  45 77 23
  81 45 19
  68 64 13

  temperature-to-humidity map:
  0 69 1
  1 0 69

  humidity-to-location map:
  60 56 37
  56 93 4
  """
  describe "seeds/1" do
    test "parses the example input" do
      assert Parsec.seeds(@example) ==
               {:ok,
                [
                  seeds: [79, 14, 55, 13],
                  map: [
                    from_to: [from: ["seed"], to: ["soil"]],
                    mappings: [mapping: [50, 98, 2], mapping: ~c"420"]
                  ],
                  map: [
                    from_to: [from: ["soil"], to: ["fertilizer"]],
                    mappings: [
                      mapping: [0, 15, 37],
                      mapping: [37, 52, 2],
                      mapping: [39, 0, 15]
                    ]
                  ],
                  map: [
                    from_to: [from: ["fertilizer"], to: ["water"]],
                    mappings: [
                      mapping: ~c"15\b",
                      mapping: [0, 11, 42],
                      mapping: [42, 0, 7],
                      mapping: [57, 7, 4]
                    ]
                  ],
                  map: [
                    from_to: [from: ["water"], to: ["light"]],
                    mappings: [mapping: [88, 18, 7], mapping: [18, 25, 70]]
                  ],
                  map: [
                    from_to: [from: ["light"], to: ["temperature"]],
                    mappings: [mapping: [45, 77, 23], mapping: [81, 45, 19], mapping: ~c"D@\r"]
                  ],
                  map: [
                    from_to: [from: ["temperature"], to: ["humidity"]],
                    mappings: [mapping: [0, 69, 1], mapping: [1, 0, 69]]
                  ],
                  map: [
                    from_to: [from: ["humidity"], to: ["location"]],
                    mappings: [mapping: ~c"<8%", mapping: [56, 93, 4]]
                  ]
                ], "", %{}, {34, 340}, 340}
    end
  end
end
