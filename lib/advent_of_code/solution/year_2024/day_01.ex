defmodule AdventOfCode.Solution.Year2024.Day01 do
  def parse_text(text) do
    text
    # split per newline
    |> String.split("\n", trim: true)
    # strip both numbers into two strings, then parse to integer
    |> Enum.map(fn line ->
      line |> String.split(~r/\s{3}/) |> Enum.map(&String.to_integer/1)
    end)
    # use accumulator to create two lists from [l, r] array 
    |> Enum.reduce({[], []}, fn [l, r], {left, right} -> {[l | left], [r | right]} end)
  end

  def total_distance(left, right) do
    left
    |> Enum.sort()
    |> Enum.zip(Enum.sort(right))
    # use accumulator to count distance between l and r
    |> Enum.reduce(0, fn {l, r}, acc -> acc + abs(l - r) end)
  end

  def part1(input) do
    input
    |> parse_text()
    |> (fn {left, right} -> total_distance(left, right) end).()
  end

  # I could've used two methods here, either 
  # - a double nested enumerator
  #   O(n * m)
  # - a frequency iterator
  #   O(n + m)
  #  
  # Obviously the second one is better, but the difference is negligible.
  def similarity_score(left, right) do
    # count the amount of matches
    right_frequencies =
      Enum.reduce(right, %{}, fn r, acc ->
        Map.update(acc, r, 1, &(&1 + 1))
      end)

    # multiply the matches by the number
    Enum.reduce(left, 0, fn l, acc ->
      acc + Map.get(right_frequencies, l, 0) * l
    end)
  end

  def part2(input) do
    input
    |> parse_text()
    |> (fn {left, right} -> similarity_score(left, right) end).()
  end
end

