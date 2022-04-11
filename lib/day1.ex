defmodule Day1 do
  @inputs Utils.load_numbers("day1.txt")

  def part1() do
    count_increase(@inputs, 0)
  end

  def part2() do
    @inputs
    |> group_measurements([])
    |> IO.inspect()
    |> count_increase(0)
  end

  def count_increase([head | tail], nb_of_increase) do
    if length(tail) > 0 do
      if Enum.at(tail, 0) > head do
        count_increase(tail, nb_of_increase + 1)
      else
        count_increase(tail, nb_of_increase)
      end
    else
      nb_of_increase
    end
  end

  def group_measurements([head | tail], grouped_list) do
    if length(tail) < 2 do
      grouped_list
    else
      [a, b] = Enum.take(tail, 2)
      sum = head + a + b
      group_measurements(tail, grouped_list ++ [sum])
    end
  end
end
