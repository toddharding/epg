defmodule Epg do
  @moduledoc """
  Documentation for Epg.
  """

  @doc """
  Parses user input

  Returns integer on success
  Returns `{:error, message}` on failure
  """
  def parse_input(x) when is_integer(x) and x > 0 do
    x
  end
  
  def parse_input(x) when is_binary(x) do
    try do
      String.to_integer(x)
      |> parse_input
    rescue
      e in ArgumentError -> {:error, "unable to parse input"}
    end
  end

  def parse_input(_) do
    {:error, "input must be a positive integer"}
  end

  @doc """
  Checks if number is prime

  Returns true if prime false if not
  Returns `{:error, message}` on failure
  """
  def is_prime(1) do
    false
  end

  def is_prime(2) do
    true
  end

  def is_prime(n) when is_integer(n) and n > 2 do
    nums = 2..n-1
    nums
    |> Enum.map(fn x -> rem(n, x) end)
    |> Enum.reduce_while(0, fn (i, acc) ->
      if i == 0, do: {:halt, false}, else: {:cont, true}
    end )
  end

  def is_prime(x) when is_binary(x) do
    {:error, "input must be an integer"}
  end

  def is_prime(x) when is_integer(x) and x < 1 do
    {:error, "input must be a positive integer"}
  end

  def is_prime(_) do
    {:error, "unable to parse input"}
  end

end
