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

  def part2(input) do
    input
    |> split_input()
    |> Enum.filter(fn line ->
      # Helper function to check if a sequence is valid
      valid_sequence = fn sequence ->
        Enum.all?(sequence, fn [a, b] -> abs(a - b) in 1..3 end) &&
          (Enum.all?(sequence, fn [a, b] -> a - b > 0 end) ||
             Enum.all?(sequence, fn [a, b] -> b - a > 0 end))
      end

      # allow at most one mistake by removing one element
      Enum.any?(0..(length(line) - 1), fn skip_index ->
        modified_line = List.delete_at(line, skip_index)
        modified_chunks = Enum.chunk_every(modified_line, 2, 1, :discard)
        valid_sequence.(modified_chunks)
      end)
    end)
    |> Enum.count()
  end
end
