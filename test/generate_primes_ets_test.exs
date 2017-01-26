defmodule Epg.Test.SOEETS.GeneratePrimes do
  use ExUnit.Case
  doctest Epg.SOEETS

  test "if input is 1, the output must be [2]" do
    assert Epg.SOEETS.generate_primes(1) == [2]
  end

  test "if input is 2, the output must be [2, 3]" do
    assert Epg.SOEETS.generate_primes(2) == [2, 3]
  end

  test "if input is 3, the output must be [2, 3, 5]" do
    assert Epg.SOEETS.generate_primes(3) == [2, 3, 5]
  end

  test "first 100 primes" do
    primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103,
      107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229,
      233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367,
      373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503,
      509, 521, 523, 541]

    assert Epg.SOEETS.generate_primes(100) == primes
  end

  test "generate_primes must output an error if given a negative number" do
    assert {:error, _message} = Epg.SOEETS.generate_primes(-2)
  end

  test "input must not be a string" do
    assert {:error, _message} = Epg.SOEETS.generate_primes("25")
  end
end