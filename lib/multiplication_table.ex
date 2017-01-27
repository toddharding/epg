defmodule Epg.MultiplicationTable do

  @doc """
    Generates and prints a multiplication table of size N + 1 x N + 1
    when given a list of integers

    Returns `{:error, message}` on failure

  """
  def generate_and_print_multiplication_table(numbers) when is_list(numbers) do
    first_row = [nil] ++ numbers
    max_width = compute_max_width(numbers)
    IO.puts generate_row_string(first_row, max_width)
    chunk_size = round(Float.ceil(length(numbers) / Epg.Utils.get_schedulers()))
    numbers
    |> Enum.chunk(chunk_size, chunk_size, [])
    |> Enum.each(fn chunk ->
        rows = compute_rows(numbers, chunk, :parallel)
        Enum.each(rows, fn row ->
          IO.puts generate_row_string(row, max_width)
        end)
      end)
  end

  defp compute_rows(numbers, multiplicands, :parallel) do
    multiplicands
    |> Enum.map(fn multiplicand ->
      Task.async(fn ->compute_row(numbers, multiplicand) end)
    end)
    |> Enum.map(fn task -> Task.await(task) end)
  end

  defp compute_rows(numbers, multiplicands) do
    multiplicands
    |> Enum.map(fn multiplicand ->
      compute_row(numbers, multiplicand)
    end)
  end

  defp compute_row(numbers, multiplicand) do
     [ multiplicand | Enum.map(numbers, fn x -> x * multiplicand end)]
  end

  defp compute_row(numbers, multiplicand, chunk_size) do
    numbers
    |> Enum.chunk(chunk_size, chunk_size, [])
    |> Enum.map(fn chunk ->
      Task.async(fn ->
          compute_row(chunk, multiplicand)
       end)
     end)
     |> Enum.map(fn task -> Task.await(task) end)
     |> Enum.concat
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

  defp compute_max_width(table) when is_list(table) do
    last_number = table |> List.flatten |> List.last
    highest_number = last_number * last_number
    highest_number |> to_string |> String.length
  end

  defp generate_number_string(number, padding, delimiter) do
    "  " <> String.duplicate(" ", padding) <> number <> " " <> delimiter
  end
end