defmodule Epg.MultiplicationTable do
  @doc """
      Generates a row major multiplication table of size N + 1 x N + 1
      when given a list of integers

      Returns `{:error, message}` on failure

      ## Examples

        iex> Epg.MultiplicationTable.generate_multiplication_table([2])
        [[nil, 2], [2, 4]]

        iex> Epg.MultiplicationTable.generate_multiplication_table([2, 3])
        [[nil, 2, 3], [2, 4, 6], [3, 6, 9]]

        iex> Epg.MultiplicationTable.generate_multiplication_table([])
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