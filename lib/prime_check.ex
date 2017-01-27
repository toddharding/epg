defmodule Epg.PrimeCheck do
  @moduledoc """
  Provides a method `is_prime/1` that checks if a positive integer is prime
  """

  @doc """
  Checks if integer is prime
  Input must be a positive integer
  Returns true if prime false if not
  Returns `{:error, message}` on failure

  ## parameters

    -n: the integer to check

  ## Examples
    iex> Epg.PrimeCheck.is_prime(5)
    true

    iex> Epg.PrimeCheck.is_prime(6)
    false

    iex> Epg.PrimeCheck.is_prime(0)
    {:error, "input must be a positive integer"}
  """
  def is_prime(x) when is_binary(x) do
    {:error, "input must be a positive integer"}
  end

  def is_prime(x) when is_integer(x) and x < 1 do
    {:error, "input must be a positive integer"}
  end

  def is_prime(1) do
    false
  end

  def is_prime(2) do
    true
  end

  def is_prime(3) do
    true
  end

  def is_prime(n) when rem(n, 2) == 0 or rem(n, 3) == 0 do
    false
  end

  def is_prime(n) when is_integer(n) and n > 2 do
    is_prime(n, 5)
  end

  def is_prime(_) do
    {:error, "unable to parse input"}
  end

  def is_prime(n, i) when (i * i) <= n do
    if rem(n, i) == 0 or rem(n, i + 2) == 0 do
      false
    else
      is_prime(n, (i + 6))
    end
  end

  def is_prime(n, i) when (i * i) > n do
    true
  end
end