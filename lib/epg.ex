defmodule Epg do
  @moduledoc """
  Elixir Prime Generator
  """

  def main(argsv \\ []) do
    {_parsed, [number], _invalid} = OptionParser.parse(argsv)
    case parse_input(number) do
      x when is_integer(x) ->
        primes = case x do
          x when x < 1024 ->
            Epg.SingleProcess.generate_primes(x)
          x when x >= 1024 ->
            Epg.MultiProcess.generate_primes(x)
        end
        primes
        |> Epg.MultiplicationTable.generate_multiplication_table
        |> Epg.MultiplicationTable.print_table
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

end


