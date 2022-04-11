defmodule Day3 do
  require Logger
  alias Tensor.Matrix
  @inputs Utils.load_inputs("day3.txt")

  def part1() do
    height = length(@inputs)
    width = String.length(List.first(@inputs))

    counts =
      @inputs
      |> Enum.map(fn line ->
        line
        |> String.split("", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.to_list()
      |> Matrix.new(height, width)
      |> Matrix.transpose()
      |> Enum.map(&Enum.sum/1)

    gamma = get_value(counts, fn c -> if c > height / 2, do: "1", else: "0" end)
    epsilon = get_value(counts, fn c -> if c <= height / 2, do: "1", else: "0" end)

    gamma * epsilon
  end

  def part2() do
    data =
      @inputs
      |> Enum.map(fn line ->
        line
        |> String.split("", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.to_list()

    cmp = fn sum, data ->
      if sum >= length(data) / 2, do: true, else: false
    end

    oxygen = get_number(data, 0, cmp)

    cmp = fn sum, data ->
      if sum < length(data) / 2 && sum != 0, do: true, else: false
    end

    co2 = get_number(data, 0, cmp)

    oxygen * co2
  end

  defp get_number(data, index, cmp) do
    if length(data) == 1 do
      data
      |> Enum.at(0)
      |> Enum.map(fn e -> Integer.to_string(e) end)
      |> Enum.join()
      |> Integer.parse(2)
      |> elem(0)
    else
      sum =
        data
        |> Enum.map(fn l -> Enum.at(l, index) end)
        |> Enum.sum()

      filtered_data =
        if cmp.(sum, data) do
          Enum.filter(data, fn x -> Enum.at(x, index) == 1 end)
        else
          Enum.filter(data, fn x -> Enum.at(x, index) == 0 end)
        end

      get_number(
        filtered_data,
        index + 1,
        cmp
      )
    end
  end

  defp get_value(counts, cmp) do
    counts
    |> Enum.map(fn c -> cmp.(c) end)
    |> Enum.join()
    |> Integer.parse(2)
    |> elem(0)
  end
end
