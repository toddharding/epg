defmodule Epg.MPFlow do
  @moduledoc """
    This module implements naive multi process
    prime number generation

    functions are:
    `generate_primes/1` generates n primes
  """

  @doc """
    Generates a list of the first `n` prime numbers

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
    approx_elements = Epg.Utils.calculate_nth_prime_approximate(n)
    generate_primes_upto(approx_elements)
    |> Enum.take(n)
  end

  def generate_primes_upto(n) when is_integer(n) and n > 3 do
    2..n
    |> Flow.from_enumerable()
    |> Flow.filter(fn i -> Epg.PrimeCheck.is_prime(i) == true end)
    |> Enum.sort
  end

  def generate_primes(_) do
    {:error, "input must be a positive integer"}
  end

end