defmodule AdventOfCode.Solution.Year2024.Day01 do
  def parse_text(text) do
    text
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line |> String.split(~r/\s{3}/) |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.reduce({[], []}, fn [l, r], {left, right} -> {[l | left], [r | right]} end)
  end

  def total_distance(left, right) do
    left
    |> Enum.sort()
    |> Enum.zip(Enum.sort(right))
    |> Enum.reduce(0, fn {l, r}, acc -> acc + abs(l - r) end)
  end

  def part1(input) do
    input
    |> parse_text()
    |> (fn {left, right} -> total_distance(left, right) end).()
  end

  def part2(_input) do
  end
end

