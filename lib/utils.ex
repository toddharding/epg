defmodule Epg.Utils do
   @doc """
      calculates the approximate value of the nth prime
      based on: https://en.wikipedia.org/wiki/Prime_number_theorem#Approximations_for_the_nth_prime_number

      Returns `{:error, message}` if anything other than an integer is entered

      ## Examples
        iex> Epg.Utils.calculate_nth_prime_approximate(5)
        11

        iex> Epg.Utils.calculate_nth_prime_approximate(7)
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

    @min_chunk_size 512
    @doc """
      used for calculating how to divide up a list for concurrent ops
    """
    def chunk_heuristic() do
      @min_chunk_size
    end
    
    def chunk_heuristic(n) when n >= @min_chunk_size do
      number_of_schedulers = :erlang.system_info(:schedulers)
      case (@min_chunk_size * number_of_schedulers) do
        x when x > n -> @min_chunk_size
        _ -> div(n, number_of_schedulers)
      end
    end
    
    def chunk_heuristic(n) when n < @min_chunk_size and n > 1 do
      n
    end

    def chunk_heuristic(_) do
      {:error, "input must be a positive integer"}
    end

    def get_schedulers do
      :erlang.system_info(:schedulers)
    end

    defp generate_multiples_upto(of, to) do
      amount = div(to, of)
      1..amount
      |> Enum.map( fn x -> of * x end)
    end

    def generate_multiples(of, from, to, acc) when rem(from, of) != 0 do
      next_from = from + (of - rem(from, of))
      generate_multiples(of, next_from, to, acc)
    end

    def generate_multiples(of, from, to, acc) when from <= to and of <= to do
      generate_multiples(of, from + of, to, [from | acc])
    end

    def generate_multiples(of, from, to, acc) when from > to or of > to do
      acc |> Enum.reverse
    end
end