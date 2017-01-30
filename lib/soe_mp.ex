defmodule SOE do

  def generate_primes_upto(n) do
    integers = 2..n
    |> Enum.filter(fn x -> rem(x, 2) != 0 end)
    |> Enum.filter(fn x -> rem(x, 3) != 0 end)
    |> Enum.filter(fn x -> rem(x, 5) != 0 end)
    |> Enum.map(fn x -> {x, :prime} end)
    p = 7
    generate_primes_upto(integers, p, [])
    |> Enum.filter(fn {_, status} -> status == :prime end)
    |> Enum.map(fn {x, _} -> x end)
  end

  def generate_primes_upto([{current_prime, :prime} = integer | t], current_prime, []) do
    generate_primes_upto(t, current_prime, [integer])
  end

  def generate_primes_upto([{n, status} = integer | t], current_prime, results) when n <= current_prime do
    generate_primes_upto(t, current_prime, [integer | results])
  end

  def generate_primes_upto([{n, :prime} | t], current_prime, results) when rem(n, current_prime) == 0 do
    generate_primes_upto(t, current_prime, [{n, :not_prime} | results])
  end

  def generate_primes_upto([{n, :not_prime} | t], current_prime, results) when rem(n, current_prime) == 0 do
      generate_primes_upto(t, current_prime, [{n, :not_prime} | results])
    end

  def generate_primes_upto([{n, status} | t], current_prime, results) when rem(n, current_prime) != 0 do
    generate_primes_upto(t, current_prime, [{n, status} | results])
  end

  def generate_primes_upto([], current_prime, results) do
    results = results |> Enum.reverse
    case find_next_prime(results, current_prime) do
      :none ->
        results
      next_prime ->
        generate_primes_upto(results, next_prime, [])
    end
  end

  def find_next_prime([], current_prime) do
    :none
  end

  def find_next_prime([{_, :not_prime} | t], current_prime) do
    find_next_prime(t, current_prime)
  end

  def find_next_prime([{current_prime, :prime} | t ] = integers, current_prime) do
    find_next_prime(t, current_prime)
  end

  def find_next_prime([{n, :prime} | t], current_prime) when n <= current_prime do
    find_next_prime(t, current_prime)
  end

  def find_next_prime([{n, :prime} | _], current_prime) when n > current_prime do
    n
  end
end