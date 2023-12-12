defmodule Advent2023.MixProject do
  use Mix.Project

  def project do
    [
      app: :advent_2023,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:libgraph, "~> 0.16.0"},
      {:mix_test_watch, "~> 1.0", only: [:dev, :test], runtime: false},
      {:nimble_parsec, "~> 1.4"},
      {:nx, "~> 0.6"},
      {:erlog,
       git: "https://github.com/rvirding/erlog", ref: "26ac2415c673683d7c816e3168048be012c86735"}
    ]
  end
end
