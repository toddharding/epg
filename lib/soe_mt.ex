defmodule Epg.SOEMT do
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
    generate_primes_upto(calculate_nth_prime_approximate(n))
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

  def chunk_heuristic(amount) do
    schedulers = :erlang.system_info(:schedulers_online)
    chunk_size = div(amount, schedulers)

    case chunk_size do
      x when x < schedulers -> 8
      x -> chunk_size
    end
  end

  defp generate_multiples_upto(of, to) do
    amount = div(to, of)
    chunk_size = chunk_heuristic(amount)
    #IO.puts "calculating multiples of #{of}, upto #{to}, with a chunk size of #{chunk_size}"
    1..amount
    |> Stream.chunk(chunk_size, chunk_size, [])
    |> Stream.map(fn multiplicands -> Task.async(fn ->
      multiplicands
      |> Enum.map(fn x -> of * x end)
     end)
    end)
    |> Stream.map(fn x -> Task.await(x) end)
    |> Enum.concat
  end

  @doc """
    calculates the approximate value of the nth prime
    based on: https://en.wikipedia.org/wiki/Prime_number_theorem#Approximations_for_the_nth_prime_number

    Returns `{:error, message}` if anything other than an integer is entered

    ## Examples
      iex> Epg.SOE.calculate_nth_prime_approximate(5)
      11

      iex> Epg.SOE.calculate_nth_prime_approximate(7)
      18
  """
  def calculate_nth_prime_approximate(1) do
      2
  end

  def calculate_nth_prime_approximate(n) when n < 6 and n > 1 do
    round((n + 1) * :math.log(n + 1))
  end

  def calculate_nth_prime_approximate(n) when n >= 6 do
    round(n * (:math.log(n) + :math.log(:math.log(n))))
  end

  def calculate_nth_prime_approximate(_) do
    {:error, "input must be a positive integer"}
  end
end