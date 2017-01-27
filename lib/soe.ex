defmodule Epg.SOE do
  @moduledoc """
    This module implements the Sieve of Eratosthenes prime number generation technique
    source: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
  """

  @doc """
    Generates a list of prime numbers of given length

    Returns `{:error, message}` if anything other than
    a positive integer is entered

    ## Examples

      iex> Epg.SOE.generate_primes(2)
      [2, 3]


      iex> Epg.SOE.generate_primes(3)
      [2, 3, 5]

    """
  def generate_primes(n) when is_integer(n) and n > 0 do
    generate_primes_upto(Epg.Utils.calculate_nth_prime_approximate(n))
    |> Enum.take(n)
  end

  def generate_primes(_) do
    {:error, "input must be a positive integer"}
  end

  @doc """
    Generates a list of prime numbers upto the given number

    Returns `{:error, message}` if anything other than an integer greater than 2 is entered

    ## Examples

      iex> Epg.SOE.generate_primes_upto(3)
      [2, 3]

      iex> Epg.SOE.generate_primes_upto(15)
      [2, 3, 5, 7, 11, 13]

  """
  def generate_primes_upto(n) when is_integer(n) and n > 1 do
    2..n
    |> Enum.map(fn x -> {x, :prime} end)                    # generate tuples of {2, :prime}..{n, :prime}
    |> Enum.into(%{})                                       # and insert into map
    |> generate_primes_upto_priv(2, n)                      # generate the prime number map
    |> Enum.filter(fn {_x, status} -> status == :prime end) # filter out the `not primes`
    |> Enum.map(fn {x, _} -> x end)                         # convert tuple back to integer removing the :prime atom
    |> Enum.sort                                            # sort in ascending order
  end

  defp generate_primes_upto_priv(numbers = %{}, p, n ) when p <= n do
    numbers = case numbers[p] do
      # if number at p is prime then generate its multiples upto n and mark them as not prime
      :prime ->
        [_ | multiples] = generate_multiples_upto(p, n)
        mark_composites(numbers, multiples)
      :not_prime ->
        numbers
    end
    generate_primes_upto_priv(numbers, p + 1, n)
  end

  defp generate_primes_upto_priv(numbers = %{}, _p, _n) do
    numbers
  end

  defp mark_composites(numbers, multiples) do
     Enum.reduce(multiples, numbers, fn x, acc ->
      Map.put(acc, x, :not_prime)
    end)
  end

  defp generate_multiples_upto(of, to) do
    amount = div(to, of)
    1..amount
    |> Enum.map( fn x -> of * x end)
  end
end