defmodule Advent2023.Day03Test do
  import Advent2023.Day03

  use ExUnit.Case

  describe "run" do
    test "solves part 1" do
      assert run() == [part_one: 528_799]
    end
  end

  describe "extract_digits/1" do
    test "returns a tensor containing only character codes in ?0..?9" do
      assert extract_digits(Nx.tensor(~c".23.$")) ==
               Nx.tensor([0, ?2, ?3, 0, 0])
    end
  end

  describe "extract_non_digits/1" do
    test "returns a tensor containing only character codes which are not zero, or in ?0..?9" do
      assert extract_non_digits(Nx.tensor(~c".23.$")) ==
               Nx.tensor([0, 0, 0, 0, ?$])
    end
  end
end
