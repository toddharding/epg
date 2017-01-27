defmodule Epg do
  @moduledoc """
  Elixir Prime Generator
  """

  @doc """
    Main entry point to application
    used by escript
  """
  def main(argsv \\ []) do
    argsv
    |> parse_args
    |> handle_args
  end

  defp parse_args(args) do
    {options, number_of_primes, _} = args
    |> OptionParser.parse(switches: [upto: :boolean, list: :boolean])
    {options, parse_input(number_of_primes)}
  end

  defp handle_args({_, {:error, message}})  do
    IO.puts message
  end

  defp handle_args({[], x}) do
    primes = case x do
      x when x < 1024 ->
        Epg.SingleProcess.generate_primes(x)
      x when x >= 1024 ->
        Epg.MultiProcess.generate_primes(x)
    end
    primes
    |> Epg.MultiplicationTable.generate_and_print_multiplication_table
  end

  defp handle_args({options, number}) do
    if options[:upto] do
      IO.puts "Generating primes from 2 to #{number}"
      Epg.SOEETS.generate_primes_upto(number)
      |> Enum.map(fn x -> IO.puts x end)
    end

    if options[:list] do
      IO.puts "Generating first #{number} primes"
      Epg.MultiProcess.generate_primes(number)
      |> Enum.map(fn x -> IO.puts x end)
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

  def parse_input([x] = l) when is_list(l) do
    parse_input(x)
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

end


