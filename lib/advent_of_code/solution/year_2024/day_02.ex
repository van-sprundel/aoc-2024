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
      # 1. don't change direction in between lines
      increasing = Enum.all?(chunks, fn [a, b] -> b - a > 0 end)
      decreasing = Enum.all?(chunks, fn [a, b] -> a - b > 0 end)

      # 2. difference between each chunk is range 1..3
      valid_diff = Enum.all?(chunks, fn [a, b] -> abs(a - b) in 1..3 end)

      (increasing || decreasing) && valid_diff
    end)
    |> Enum.count()
  end

  # same for part2, but if removing max 1 element fixes it then it's also valid
  def part2(input) do
    input
    |> split_input()
    |> Enum.filter(fn line ->
      Enum.any?(0..(length(line) - 1), fn skip_index ->
        modified_line = List.delete_at(line, skip_index)
        chunks = Enum.chunk_every(modified_line, 2, 1, :discard)

        increasing = Enum.all?(chunks, fn [a, b] -> b - a > 0 end)
        decreasing = Enum.all?(chunks, fn [a, b] -> a - b > 0 end)
        valid_diff = Enum.all?(chunks, fn [a, b] -> abs(a - b) in 1..3 end)

        (increasing || decreasing) && valid_diff
      end)
    end)
    |> Enum.count()
  end
end
