defmodule Day4 do
  require Logger

  def part1() do
    load_file()
  end

  defp load_file() do
    fstream = File.stream!("inputs/day4_short.txt")

    draws =
      fstream
      |> Stream.take(1)
      |> Stream.map(&String.trim/1)
      |> Enum.to_list()
      |> Enum.at(0)
      |> String.split(",")

    # |> IO.inspect()

    boards =
      fstream
      |> Stream.drop(1)
      |> Stream.drop_every(6)
      |> Stream.chunk_every(5)
      |> Stream.map(fn chunk ->
        chunk
        |> Stream.map(&String.trim/1)
        |> Stream.map(&String.split/1)
        |> Stream.map(fn row ->
          row
          |> Enum.into(%{}, fn k ->
            {k, 0}
          end)
        end)
        |> Enum.to_list()
      end)
      |> Enum.to_list()

    play_game(draws, boards)
  end

  def play_game([draw | draws], boards) do
    Logger.info("Playing game with draw " <> draw)

    updated_boards =
      boards
      |> Enum.map(fn board ->
        board
        |> Enum.map(fn row ->
          if Map.has_key?(row, draw), do: %{row | draw => 1}, else: row
        end)
      end)

    get_winner_board(updated_boards)
    play_game(draws, updated_boards)
    # |> IO.inspect()

    # IO.inspect(updated_boards)
  end

  def get_winner_board(boards) do
    boards
    |> Enum.filter()
  end

  def check_board(board) do
    board
    |> Enum.filter()
  end
end
