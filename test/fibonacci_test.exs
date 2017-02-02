defmodule Epg.Test.Fibonacci do
  use ExUnit.Case

  test "output is correct when 1 is given" do
    assert Epg.Fibonacci.generate_sequence(1) == [1]
  end

  test "output is correct when 2 is given" do
    assert Epg.Fibonacci.generate_sequence(2) == [1, 1]
  end

  test "output is correct when 3 is given" do
    assert Epg.Fibonacci.generate_sequence(3) == [1, 1, 2]
  end

  test "output is correct when 4 is given" do
    assert Epg.Fibonacci.generate_sequence(4) == [1, 1, 2, 3]
  end

  test "output is correct when 5 is given" do
    assert Epg.Fibonacci.generate_sequence(5) == [1, 1, 2, 3, 5]
  end

  test "output is correct when 6 is given" do
    assert Epg.Fibonacci.generate_sequence(6) == [1, 1, 2, 3, 5, 8]
  end

  test "output is correct when 7 is given" do
    assert Epg.Fibonacci.generate_sequence(7) == [1, 1, 2, 3, 5, 8, 13]
  end

  test "input must be an integer" do
    assert {:error, _} = Epg.Fibonacci.generate_sequence("test")
  end

  test "input must be a positive integer" do
    assert {:error, _} = Epg.Fibonacci.generate_sequence(-20)
  end
end