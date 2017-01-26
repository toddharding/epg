defmodule Epg do
  @moduledoc """
  Documentation for Epg.
  """



  def main(argsv \\ []) do
    {_parsed, [number], _invalid} = OptionParser.parse(argsv)
    case parse_input(number) do
      x when is_integer(x) ->
        Epg.SOE.generate_primes(x)
        |> generate_multiplication_table
        |> print_table
      {:error, message} -> IO.puts message
    end
  end

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
      _e in ArgumentError -> {:error, "unable to parse input"}
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

  def is_prime(3) do
    true
  end

  def is_prime(n) when rem(n, 2) == 0 or rem(n, 3) == 0 do
    false
  end

  def is_prime(n) when is_integer(n) and n > 2 do
    is_prime(n, 5)
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

  @doc """
    Generates a list of prime numbers of given length

    Returns `{:error, message}` if anything other than
    a positive integer is entered

    ## Examples

      iex> Epg.generate_primes(2)
      [2, 3]


      iex> Epg.generate_primes(3)
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
    primes
  end

  defp generate_primes_priv(n, highest_number, primes) do
    next_num = highest_number + 1
    case is_prime(next_num) do
      true -> generate_primes_priv(n - 1, next_num, primes ++ [next_num])
      false -> generate_primes_priv(n, next_num, primes)
    end
  end

  @doc """
    Generates a row major multiplication table of size N + 1 x N + 1
    when given a list of integers

    Returns `{:error, message}` on failure

    ## Examples

      iex> Epg.generate_multiplication_table([2])
      [[nil, 2], [2, 4]]

      iex> Epg.generate_multiplication_table([2, 3])
      [[nil, 2, 3], [2, 4, 6], [3, 6, 9]]

      iex> Epg.generate_multiplication_table([])
      []

  """
  def generate_multiplication_table([]) do
    []
  end

  def generate_multiplication_table(numbers) when is_list(numbers) do
    first_row = [nil] ++ numbers
    list_length = length(numbers)
    try do
      [first_row] ++ Enum.map(1..list_length, fn x -> generate_multiplication_table_row(x, numbers) end)
    rescue
      _e in ArithmeticError -> {:error, "input must be a list of numbers"}
    end
  end

  def generate_multiplication_table(numbers) when is_list(numbers) == false do
    {:error, "input must be a list of numbers"}
  end

  defp generate_multiplication_table_row(n, numbers) do
    coefficient = numbers |> Enum.at(n - 1)
    [coefficient] ++ Enum.map(numbers, fn x -> coefficient * x end)
  end

  @doc """
    prints a table to stdio (a list of lists)
    Returns `{:error, message}` on failure

  """
  def print_table([]) do
    IO.puts "table is empty"
  end

  def print_table(table) when is_list(table) do
    max_width = table |> convert_all_to_string |> get_largest_string_size
    Enum.map(table, fn row -> IO.puts generate_row_string(row, max_width)  end)
  end

  def print_table(table) when is_list(table) == false do
    {:error, "input must be a list"}
  end

  defp generate_row_string(row, max_width) when is_list(row) do
    delimiter = "|"
    row_string = row |> Enum.map(fn x ->
      number_string = to_string(x)
      padding = max_width - String.length(number_string)
      generate_number_string(number_string, padding, delimiter)
    end)
    |> List.to_string()
    delimiter <> row_string
  end

  defp generate_number_string(number, padding, delimiter) do
    "  " <> String.duplicate(" ", padding) <> number <> " " <> delimiter
  end

  defp get_largest_string_size(numbers) when is_list(numbers) do
    Enum.max_by(numbers, &String.length/1) |> String.length
  end

  defp convert_all_to_string(x) when is_list(x) do
    x |> List.flatten() |> Enum.map(fn s -> to_string(s) end)
  end
end


