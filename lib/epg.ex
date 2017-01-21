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

end
