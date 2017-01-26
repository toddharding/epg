defmodule Epg.SOEETS do
  @moduledoc """
    This module implements the Sieve of Eratosthenes prime number generation technique
    And uses ETS for storage
    source: https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
  """

  @doc """
    Generates a list of prime numbers of given length

    Returns `{:error, message}` if anything other than
    a positive integer is entered

    ## Examples

      iex> Epg.SOEETS.generate_primes(2)
      [2, 3]


      iex> Epg.SOEETS.generate_primes(3)
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

      iex> Epg.SOEETS.generate_primes_upto(3)
      [2, 3]

      iex> Epg.SOEETS.generate_primes_upto(15)
      [2, 3, 5, 7, 11, 13]

  """
  def generate_primes_upto(n) when is_integer(n) and n > 1 do
    ets_table = :ets.new(:primes_table, [:ordered_set, :public, {:write_concurrency, true}])
    2..n
    |> Enum.map(fn x -> :ets.insert(ets_table, {x, :prime}) end)

    generate_primes_upto_priv(ets_table, 2, n)
    prime_numbers = :ets.tab2list(ets_table)
    |> Enum.filter(fn {_, status} -> status == :prime end)
    |> Enum.map(fn {x, _} -> x end)
    #|> Enum.sort
    :ets.delete(ets_table)
    prime_numbers
  end

  defp generate_primes_upto_priv(ets_table, p, n ) when p <= n do
    p..n
    |> Enum.map(fn i ->
      case :ets.lookup(ets_table, i) do
        [{i, :prime}] ->
          generate_and_mark_multiples_upto(ets_table, i, n)
        _ -> :ok
      end
    end)
  end

  defp generate_and_mark_multiples_upto(_, n, n) do
    nil
  end

  defp generate_and_mark_multiples_upto(ets_table, of, to) do
    amount = div(to, of)
    case amount do
      x when x < 2 -> nil
      _ ->
        2..amount
        |> Enum.each(fn x -> :ets.insert(ets_table, {of * x, :not_prime})  end)
    end
  end
end