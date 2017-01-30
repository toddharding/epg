defmodule Epg.Bench.PrimeGenerators do
  use Benchfella

  bench "1000 with multi process" do
    Epg.MultiProcess.generate_primes(1000)
  end
#
  bench "1000 with Flow" do
    Epg.MPFlow.generate_primes(1000)
  end

 bench "1000 with FlowETS" do
    Epg.FlowETS.generate_primes(1000)
  end

  bench "100000 with multi process" do
    Epg.MultiProcess.generate_primes(100000)
  end
#
  bench "100000 with Flow" do
    Epg.MPFlow.generate_primes(100000)
  end

  bench "100000 with FlowETS" do
    Epg.FlowETS.generate_primes(100000)
  end


  bench "1000000 with multi process" do
    Epg.MultiProcess.generate_primes(1000000)
  end

  bench "1000000 with Flow" do
    Epg.MPFlow.generate_primes(1000000)
  end

  bench "1000000 with FlowETS" do
    Epg.FlowETS.generate_primes(1000000)
  end

end