defmodule Epg.Bench.PrimeGenerators do
  use Benchfella

  bench "1000 with 1 process" do
    Epg.SingleProcess.generate_primes(1000)
  end

  bench "1000 with multi process" do
    Epg.MultiProcess.generate_primes(1000)
  end

  bench "100000 with 1 process" do
    Epg.SingleProcess.generate_primes(100000)
  end

  bench "100000 with multi process" do
    Epg.MultiProcess.generate_primes(100000)
  end

  bench "500000 with 1 process" do
    Epg.SingleProcess.generate_primes(500000)
  end

  bench "500000 with multi process" do
    Epg.MultiProcess.generate_primes(500000)
  end

end