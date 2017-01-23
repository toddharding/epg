defmodule Epg.NMT do
  @moduledoc """
    This module implements basic multi threading based off of the naive
    single threaded prime number generator
  """

  def check_numbers(numbers) when is_list(numbers) do
    numbers |> Enum.map(fn {n, _status} ->
        case Epg.is_prime(n) do
          true -> {n, :prime}
          false -> {n, :not_prime}
        end
     end)
  end

  def generate_primes(n) when is_integer(n) and n > 0 do
    primes = Stream.unfold(3, fn x -> {x, x + 1} end)
    |> Stream.take_every(2)
    |> Stream.map(fn x -> {x, :not_prime} end)
    |> Stream.chunk(16)
    |> Stream.map(fn x ->
      Task.async(__MODULE__, :check_numbers, [x])
     end)
    |> Stream.map(fn x -> Task.await(x) end)
    |> Stream.concat
    |> Stream.filter(fn {_, status} -> status == :prime  end)
    |> Stream.map(fn {number, _} -> number end)
    |> Enum.take(n - 1)
    [2] ++ primes
  end

  def generate_primes(_) do
    {:error, "input must be a positive integer"}
  end

end