defmodule Epg.Bench.PrimeGenerators do
  use Benchfella

  # 10 prime numbers
  bench "Naive prime generator first 10 prime numbers" do
      Epg.generate_primes(10)
    end

  bench "Naive Multi Threading first 10 prime numbers" do
    Epg.NMT.generate_primes(10)
  end

  bench "Sieve of Eratosthenes first 10 prime numbers" do
    Epg.SOE.generate_primes(10)
  end

  # 100 prime numbers
  bench "Naive prime generator first 100 prime numbers" do
    Epg.generate_primes(100)
  end

  bench "Naive Multi Threading first 100 prime numbers" do
    Epg.NMT.generate_primes(100)
  end

  bench "Sieve of Eratosthenes first 100 prime numbers" do
    Epg.SOE.generate_primes(100)
  end

  # 1000 prime numbers
  bench "Naive prime generator first 1000 prime numbers" do
    Epg.generate_primes(1000)
  end

  bench "Naive Multi Threading first 1000 prime numbers" do
    Epg.NMT.generate_primes(1000)
  end

  bench "Sieve of Eratosthenes first 1000 prime numbers" do
    Epg.SOE.generate_primes(1000)
  end
end