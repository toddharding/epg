defmodule Epg.MultiProcess do
  @moduledoc """
    This module implements basic multi threading based off of the naive
    single threaded prime number generator

    functions are:
    `generate_primes/1` generates n primes
  """

  @doc """
    Generates a list of prime numbers of given length

    Returns `{:error, message}` if anything other than
    a positive integer is entered

    ## parameters

      -n: number of primes to generate

    ## Examples

      iex> Epg.MultiProcess.generate_primes(2)
      [2, 3]


      iex> Epg.MultiProcess.generate_primes(3)
      [2, 3, 5]

  """
  def generate_primes(1) do
    [2]
  end

  def generate_primes(2) do
    [2, 3]
  end

  def generate_primes(3) do
    [2, 3, 5]
  end

  def generate_primes(n) when is_integer(n) and n > 3 do
    chunk_size = Epg.Utils.chunk_heuristic()
    approx_elements = Epg.Utils.calculate_nth_prime_approximate(n)
    2..approx_elements
    |> Enum.chunk(chunk_size, chunk_size, [])
    |> Enum.map(fn x ->
      Task.async(fn ->
        Enum.filter(x, fn i -> Epg.PrimeCheck.is_prime(i) == true end)
      end)
     end)
     |> Enum.map(fn x -> Task.await(x) end)
     |> Enum.concat
     |> Enum.take(n)
  end

  def generate_primes(_) do
    {:error, "input must be a positive integer"}
  end

end