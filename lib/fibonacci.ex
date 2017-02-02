defmodule Epg.Fibonacci do
  @moduledoc false

  def generate_sequence(amount) when is_integer(amount) == false or amount < 1 do
    {:error, "please input a positive number"}
  end

  def generate_sequence(1) do
    [1]
  end

  def generate_sequence(2) do
    [1] ++ generate_sequence(1)
  end

  def generate_sequence(3) do
    sum_of_previous = generate_sequence(2)
    |> Enum.reduce(0, fn seq_integer, acc -> acc + seq_integer  end)
    generate_sequence(2) ++ [sum_of_previous]
  end

  def generate_sequence(amount) do
    first_3 = generate_sequence(3)
    generate_sequence(amount - 3, first_3)
  end

  def generate_sequence(0, sequence) do
    sequence
  end

  def generate_sequence(amount, sequence) do
    last_2_in_sequence = get_last_2_in_sequence(sequence)
    next_sequence = sequence ++ [sum_of_2(last_2_in_sequence)]
    generate_sequence(amount - 1, next_sequence)
  end

  def get_last_2_in_sequence(sequence) do
    Enum.take(sequence, -2)
  end

  def sum_of_2([numberA, numberB]) do
    numberA + numberB
  end
end