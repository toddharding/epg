defmodule Epg.SingleProcess do
  @moduledoc """
    This module implements naive single process
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

      iex> Epg.SingleProcess.generate_primes(2)
      [2, 3]


      iex> Epg.SingleProcess.generate_primes(3)
      [2, 3, 5]

  """
    def generate_primes(n) when is_integer(n) and n > 0 do
      generate_primes_priv(n, 0, [])
    end

    def generate_primes(n) when n < 1 do
      {:error, "input must be a positive integer"}
    end

    def generate_primes(n) when is_binary(n) do
      {:error, "input must be a positive integer"}
    end

    defp generate_primes_priv(0, _highest_prime, primes) do
      primes |> Enum.reverse
    end

    defp generate_primes_priv(n, highest_number, primes) do
      next_num = highest_number + 1
      case Epg.PrimeCheck.is_prime(next_num) do
        true -> generate_primes_priv(n - 1, next_num, [next_num | primes])
        false -> generate_primes_priv(n, next_num, primes)
      end
    end
end