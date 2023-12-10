defmodule Advent2023.Day08 do
  alias Graph.Edge
  use Advent2023.Day, input: :lines

  @adjacency_list_re ~r/(?<node>[A-Z]{3}) = \((?<left>[A-Z]{3}), (?<right>[A-Z]{3})\)/

  def parse_input([instructions, "" | graph]) do
    edges = Enum.flat_map(graph, &parse_line/1)

    {
      parse_instructions(instructions),
      Enum.reduce(edges, Graph.new(), &Graph.add_edge(&2, &1))
    }
  end

  def parse_instructions(instructions) do
    instructions
    |> String.to_charlist()
    |> Enum.map(fn
      ?L -> :left
      ?R -> :right
    end)
  end

  def parse_line(line) do
    %{
      "left" => left,
      "node" => node,
      "right" => right
    } = Regex.named_captures(@adjacency_list_re, line)

    [
      Edge.new(node, left, label: :left),
      Edge.new(node, right, label: :right)
    ]
  end

  def part_one(input) do
    {instructions, graph} = parse_input(input)

    supergraph = build_supergraph(graph, instructions)
    path = Graph.dijkstra(supergraph, "AAA", "ZZZ")
    n_edges = Enum.count(path) - 1

    n_edges * Enum.count(instructions)
  end

  def build_supergraph(graph, instructions) do
    graph
    |> Graph.vertices()
    |> Enum.map(&{&1, follow_instructions(graph, &1, instructions)})
    |> then(&Graph.add_edges(Graph.new(), &1))
  end

  def follow_instructions(graph, start_node, instructions) do
    Enum.reduce(instructions, start_node, fn instruction, current_node ->
      follow(graph, current_node, instruction)
    end)
  end

  def follow(graph, node, left_or_right) do
    case Graph.out_edges(graph, node) do
      [%{label: :left} = l, %{label: :right} = r] ->
        %{left: l, right: r}

      [%{label: :right} = r, %{label: :left} = l] ->
        %{left: l, right: r}
    end
    |> Map.fetch!(left_or_right)
    |> Map.fetch!(:v2)
  end
end
