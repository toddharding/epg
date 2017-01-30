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
  def generate_primes(n) when is_integer(n) and n < 32 and n > 0 do
    Epg.SOE.generate_primes(n)
  end
  def generate_primes(n) when is_integer(n) and n >= 32 do
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
  def generate_primes_upto(n) when is_integer(n) do
    pid = spawn_link(__MODULE__, :generate_primes_upto, [self, n])
    receive do
      {:found_primes, primes} -> primes
    end
  end

  def generate_primes_upto(caller, n) when is_integer(n) and n > 1 do
    chunks = 1
    ranges = calculate_partition_data(n, chunks)
    partitions = Enum.reduce(ranges, %{}, fn [chunk_id: id, range: %{from: from, to: to}] = data, acc ->
      partition_data = Enum.into(data, %{pid: spawn_link(__MODULE__, :partition, [[], from, to]), status: :idle })
      Map.put(acc, id, partition_data)
    end)

    self_pid = self()
    partitions = Enum.reduce(partitions, %{}, fn {id, %{pid: pid} = data}, acc ->
      send(pid, {:mark_composites, 2, self_pid, id})
      Map.put(acc, id, Map.put(data, :status, :working))
    end)
    generate_primes_upto(caller, n, 2, chunks, ranges, partitions)
  end

  def generate_primes_upto(caller, n, current_prime, chunks, ranges, partitions) do
    receive do
      {:composites_marked, chunk_id, number} ->
        partitions = update_partition_data(partitions, chunk_id, :idle)
        {next_prime, partitions} =  case check_if_all_partitions_are_idle(partitions) do
          :not_idle ->
            {current_prime, partitions}
          :idle ->
            # if so calculate next prime
            # and send mark_composites message to partitions
            next_prime = calculate_next_prime(current_prime, partitions)
            self_pid = self()
            partitions = Enum.reduce(partitions, %{}, fn {id, %{pid: pid, status: status} = data}, acc ->
              case status do
                :done ->
                  Map.put(acc, id, data)
                :idle ->
                  send(pid, {:mark_composites, next_prime, self_pid, id })
                  Map.put(acc, id, Map.put(data, :status, :working))
              end
            {next_prime, partitions}
            end)
        end
        generate_primes_upto(caller, n, next_prime, chunks, ranges, partitions)
      {:done, chunk_id} ->
        partitions = update_partition_data(partitions, chunk_id, :done)
        # check if all are done
        # if all are done aggregate partition data
        # and send complete message to caller
        work_status = check_if_all_partitions_have_completed(partitions)
        case work_status do
          :done ->
            primes = Enum.map(partitions, fn {id, %{pid: pid}} ->
              send(pid, {:get_numbers, self()})
              receive do
                numbers when is_map(numbers) ->
                numbers
              end
            end)
            |> Enum.concat
            |> Enum.filter(fn {number, status} -> status == :prime end)
            |> Enum.map(fn {x, status} -> x end)
            |> Enum.dedup
            |> Enum.sort
            send(caller, {:found_primes, primes})
          _ ->
            generate_primes_upto(caller, n, current_prime, chunks, ranges, partitions)
        end
    end
  end

  def update_partition_data(partitions, chunk_id, status) do
    partition = partitions
    |> Map.get(chunk_id)
    |> Map.put(:status, status)
    Map.put(partitions, chunk_id, partition)
  end

  defp check_if_all_partitions_have_completed(partitions) do
    partitions
    |> Enum.reduce_while(:not_done, fn {_id, %{status: status}}, acc ->
      case status do
        :done -> {:cont, :done}
        _ -> {:halt, :not_done}
      end
    end)
  end

  defp check_if_all_partitions_are_idle(partitions) do
    idle_status = partitions
    |> Enum.reduce_while(:not_idle, fn {_id, %{status: status}}, acc ->
      case status do
        :idle -> {:cont, :idle}
        :done -> {:cont, :idle}
        _ -> {:halt, :not_idle}
      end
    end)
    #IO.puts "idle status is"
    #IO.inspect idle_status
    idle_status
  end

  def merge_complete_partition_data(partitions) do

  end

  def calculate_next_prime(current_prime, partitions) do
    partitions
    |> Enum.filter(fn {_id, %{status: status}} -> status != :done end)
    |> Enum.map(fn {_id, %{pid: pid}} ->
      send(pid, {:find_lowest_unmarked, current_prime, self()})
      receive do
        x when is_integer(x) -> x
        nil -> nil
      end
     end)
     |> Enum.filter(fn x -> x != nil end)
     |> Enum.sort
     |> List.first
  end

  def start_mark_composites(caller, partitions, number) do
    Enum.each(partitions, fn %{pid: pid, chunk_id: chunk_id} -> send(pid, {:mark_composites, number, caller, chunk_id})  end)
  end

  def calculate_partition_data(upto, number_of_chunks) do
    0..(number_of_chunks - 1)
    |> Enum.map(fn x -> [{:chunk_id, x}, {:range, calculate_partition_range(upto, number_of_chunks, x)}] end)
  end

  def calculate_partition_range(upto, chunks, chunk_number) do
    # upto = 30, chunks = 5, chunk_number = 3
    number_in_chunk = round(Float.ceil(upto / chunks))
    from = number_in_chunk * chunk_number
    to = from + number_in_chunk
    %{from: Enum.max([2, from]), to: Enum.min([to, upto])}
  end

  def partition(numbers, from, to) do
    numbers = case numbers do
      %{} ->
        numbers
      _ ->
        create_partition_number_data(from, to)
    end
    receive do
      {:mark_composites, number, caller, chunk_id} ->
        marked_numbers = case number do
          x when x >= to ->
            send(caller, {:done, chunk_id})
            numbers
          x ->
            first_multiple = find_first_multiple(numbers, number)
            updated_numbers = case first_multiple do
              nil ->
                numbers
              {x, :prime} when x == number ->
                mark_all_multiples(numbers, number, x + 1, to)
              {x, :prime} ->
                mark_all_multiples(numbers, number, x, to)
            end
            send(caller, {:composites_marked, chunk_id, number})
            updated_numbers
        end
        partition(marked_numbers, from, to)
      {:find_lowest_unmarked, greater_than, caller} ->
        potential_primes = numbers
        |> Enum.filter(fn {_number, status} -> status == :prime  end)
        |> Enum.filter(fn {number, status} -> number > greater_than  end)
        |> Enum.sort
        |> Enum.map(fn {number, _} -> number end)

        case potential_primes do
          [] -> send(caller, nil)
          [h | t] -> send(caller, h)
        end
        partition(numbers, from, to)
      {:get_numbers, caller} ->
        send(caller, numbers)
        partition(numbers, from, to)
    end
  end

  def find_first_multiple(numbers, n) do
    numbers
    #|> Enum.filter(fn {_, status} -> status == :prime end)
    |> Enum.sort
    |> Enum.find(fn {x, status} -> rem(x, n) == 0 and status == :prime end)
  end

  def create_partition_number_data(from, to) do
    from..to |> Enum.map(fn x -> {x, :prime} end) |> Enum.into(%{})
  end

  def generate_multiples(of, from, to, acc) when rem(from, of) != 0 do
    next_from = from + (of - rem(from, of))
    generate_multiples(of, next_from, to, acc)
  end

  def generate_multiples(of, from, to, acc) when from <= to and of <= to do
    generate_multiples(of, from + of, to, acc ++ [from])
  end

  def generate_multiples(of, from, to, acc) when from > to or of > to do
    acc
  end

  def mark_composites(multiples, numbers) do
    updated_numbers = Enum.reduce(multiples, numbers, fn x, acc ->
      Map.put(acc, x, :not_prime)
    end)
    updated_numbers
  end


  def mark_all_multiples(numbers, of, from, to) do
    multiples = generate_multiples(of, from, to, [])
    updated_numbers = generate_multiples(of, from, to, [])
    |> mark_composites(numbers)
    updated_numbers
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