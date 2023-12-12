defmodule Advent2023.Prolog do
  use GenServer
  # Callbacks

  def start_link(source_file) do
    GenServer.start_link(__MODULE__, source_file, name: __MODULE__)
  end

  @impl true
  def init(file) do
    path = System.find_executable("swipl")
    port = Port.open({:spawn_executable, path}, [:binary, args: ["-s", file]])

    {:ok, port}
  end

  @impl true
  def handle_call({:prove, goal, parser}, _from, port) do
    send(port, {self(), {:command, "#{goal}\n"}})

    receive do
      {^port, {:data, reply}} ->
        parsed =
          reply
          |> String.trim()
          |> handle_prolog(parser)

        {:reply, parsed, port}
    end
  end

  def prove(goal, parser) when is_binary(goal) do
    GenServer.call(__MODULE__, {:prove, goal, parser})
  end

  def handle_prolog("R = " <> result, parser) do
    parser.(result)
  end

  def solve(pattern, spec) do
    parser = fn x ->
      x
      |> Integer.parse()
      |> then(fn {n, "."} -> n end)
    end

    prove("count_solutions(#{pattern}, #{spec}, R).", parser)
  end

  def handle_info(msg, state) do
    IO.inspect(msg)
  end
end
