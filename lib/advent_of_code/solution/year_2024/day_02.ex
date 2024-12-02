defmodule AdventOfCode.Solution.Year2024.Day02 do
  def split_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end

  def part1(input) do
    input
    |> split_input()
    |> Enum.filter(fn line ->
      chunks = Enum.chunk_every(line, 2, 1, :discard)

      # 2 rules
      # 1. dont change between decr/incr in the same line
      same_direction =
        chunks
        |> Enum.map(fn [a, b] -> a - b end)
        |> Enum.all?(fn diff -> diff > 0 end) ||
          Enum.all?(chunks, fn [a, b] -> b - a > 0 end)

      # 2. difference has to be range 1..3
      valid_differences =
        Enum.all?(chunks, fn [a, b] ->
          abs(a - b) in 1..3
        end)

      same_direction && valid_differences
    end)
    |> Enum.count()
  end

  def part2(_input) do
  end
end
