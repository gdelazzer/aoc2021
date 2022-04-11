defmodule Utils do
  def load_inputs(filename) do
    {_ok, data} = File.read("inputs/" <> filename)

    data
    |> String.split()
  end

  def load_numbers(filename) do
    load_inputs(filename)
    |> Enum.map(&String.to_integer/1)
  end
end
