defmodule Epg.Bench.PrimeGenerators do
  use Benchfella
  
  #16 
  bench "Sieve of Eratosthenes first 16 prime numbers" do
    Epg.SOE.generate_primes(16)
  end

  bench "ETS Sieve of Eratosthenes first 16 prime numbers" do
    Epg.SOEETS.generate_primes(16)
  end

  bench "Naive prime generator first 16 prime numbers" do
    Epg.generate_primes(16)
  end

  bench "Naive Multi Threading first 16 prime numbers" do
    Epg.NMT.generate_primes(16)
  end
  
  #32 
  bench "Sieve of Eratosthenes first 32 prime numbers" do
    Epg.SOE.generate_primes(32)
  end

  bench "ETS Sieve of Eratosthenes first 32 prime numbers" do
    Epg.SOEETS.generate_primes(32)
  end

  bench "Naive prime generator first 32 prime numbers" do
    Epg.generate_primes(32)
  end

  bench "Naive Multi Threading first 32 prime numbers" do
    Epg.NMT.generate_primes(32)
  end

  #64 
  bench "Sieve of Eratosthenes first 64 prime numbers" do
    Epg.SOE.generate_primes(64)
  end

  bench "ETS Sieve of Eratosthenes first 64 prime numbers" do
    Epg.SOEETS.generate_primes(64)
  end

  bench "Naive prime generator first 64 prime numbers" do
    Epg.generate_primes(64)
  end

  bench "Naive Multi Threading first 64 prime numbers" do
    Epg.NMT.generate_primes(64)
  end
  
  #128 
  bench "Sieve of Eratosthenes first 128 prime numbers" do
    Epg.SOE.generate_primes(128)
  end

  bench "ETS Sieve of Eratosthenes first 128 prime numbers" do
    Epg.SOEETS.generate_primes(128)
  end

  bench "Naive prime generator first 128 prime numbers" do
    Epg.generate_primes(128)
  end

  bench "Naive Multi Threading first 128 prime numbers" do
    Epg.NMT.generate_primes(128)
  end

  #256 
  bench "Sieve of Eratosthenes first 256 prime numbers" do
    Epg.SOE.generate_primes(256)
  end

  bench "ETS Sieve of Eratosthenes first 256 prime numbers" do
    Epg.SOEETS.generate_primes(256)
  end

  bench "Naive prime generator first 256 prime numbers" do
    Epg.generate_primes(256)
  end

  bench "Naive Multi Threading first 256 prime numbers" do
    Epg.NMT.generate_primes(256)
  end
  
  #512 
  bench "Sieve of Eratosthenes first 512 prime numbers" do
    Epg.SOE.generate_primes(512)
  end

  bench "ETS Sieve of Eratosthenes first 512 prime numbers" do
    Epg.SOEETS.generate_primes(512)
  end

  bench "Naive prime generator first 512 prime numbers" do
    Epg.generate_primes(512)
  end

  bench "Naive Multi Threading first 512 prime numbers" do
    Epg.NMT.generate_primes(512)
  end
  
  #1024 
  bench "Sieve of Eratosthenes first 1024 prime numbers" do
    Epg.SOE.generate_primes(1024)
  end

  bench "ETS Sieve of Eratosthenes first 1024 prime numbers" do
    Epg.SOEETS.generate_primes(1024)
  end

  bench "Naive prime generator first 1024 prime numbers" do
    Epg.generate_primes(1024)
  end

  bench "Naive Multi Threading first 1024 prime numbers" do
    Epg.NMT.generate_primes(1024)
  end
  
  #2048 
  bench "Sieve of Eratosthenes first 2048 prime numbers" do
    Epg.SOE.generate_primes(2048)
  end

  bench "ETS Sieve of Eratosthenes first 2048 prime numbers" do
    Epg.SOEETS.generate_primes(2048)
  end

  bench "Naive prime generator first 2048 prime numbers" do
    Epg.generate_primes(2048)
  end

  bench "Naive Multi Threading first 2048 prime numbers" do
    Epg.NMT.generate_primes(2048)
  end

  #4096 
  bench "Sieve of Eratosthenes first 4096 prime numbers" do
    Epg.SOE.generate_primes(4096)
  end

  bench "ETS Sieve of Eratosthenes first 4096 prime numbers" do
    Epg.SOEETS.generate_primes(4096)
  end

  bench "Naive prime generator first 4096 prime numbers" do
    Epg.generate_primes(4096)
  end

  bench "Naive Multi Threading first 4096 prime numbers" do
    Epg.NMT.generate_primes(4096)
  end

  #8192 
  bench "Sieve of Eratosthenes first 8192 prime numbers" do
    Epg.SOE.generate_primes(8192)
  end

  bench "ETS Sieve of Eratosthenes first 8192 prime numbers" do
    Epg.SOEETS.generate_primes(8192)
  end

  bench "Naive prime generator first 8192 prime numbers" do
    Epg.generate_primes(8192)
  end

  bench "Naive Multi Threading first 8192 prime numbers" do
    Epg.NMT.generate_primes(8192)
  end
  
  #16384 
  bench "Sieve of Eratosthenes first 16384 prime numbers" do
    Epg.SOE.generate_primes(16384)
  end

  bench "ETS Sieve of Eratosthenes first 16384 prime numbers" do
    Epg.SOEETS.generate_primes(16384)
  end

  bench "Naive prime generator first 16384 prime numbers" do
    Epg.generate_primes(16384)
  end

  bench "Naive Multi Threading first 16384 prime numbers" do
    Epg.NMT.generate_primes(16384)
  end
  
  #32768 
  bench "Sieve of Eratosthenes first 32768 prime numbers" do
    Epg.SOE.generate_primes(32768)
  end

  bench "ETS Sieve of Eratosthenes first 32768 prime numbers" do
    Epg.SOEETS.generate_primes(32768)
  end

  bench "Naive prime generator first 32768 prime numbers" do
    Epg.generate_primes(32768)
  end

  bench "Naive Multi Threading first 32768 prime numbers" do
    Epg.NMT.generate_primes(32768)
  end

end