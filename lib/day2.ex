defmodule Day2 do
  require Logger

  def part1() do
    File.stream!("inputs/day2.txt")
    |> Stream.map(&String.trim(&1))
    |> Stream.map(&String.split(&1))
    |> Enum.to_list()
    |> Enum.reduce({0, 0}, fn [command, value], {position, depth} ->
      case command do
        "forward" ->
          {position + String.to_integer(value), depth}

        "up" ->
          {position, depth - String.to_integer(value)}

        "down" ->
          {position, depth + String.to_integer(value)}

        _ ->
          {position, depth}
      end
    end)
    |> Tuple.to_list()
    |> Enum.product()
  end

  def part2() do
    File.stream!("inputs/day2.txt")
    |> Stream.map(&String.trim(&1))
    |> Stream.map(&String.split(&1))
    |> Enum.to_list()
    |> Enum.reduce({0, 0, 0}, fn [command, value], {position, depth, aim} ->
      case command do
        "forward" ->
          case aim do
            0 ->
              {position + String.to_integer(value), depth, aim}

            _ ->
              {position + String.to_integer(value), depth + aim * String.to_integer(value), aim}
          end

        "up" ->
          {position, depth, aim - String.to_integer(value)}

        "down" ->
          {position, depth, aim + String.to_integer(value)}

        _ ->
          {position, depth, aim}
      end
    end)
    |> Tuple.to_list()
    |> Enum.take(2)
    |> Enum.product()
  end
end
