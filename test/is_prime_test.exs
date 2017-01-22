defmodule Epg.Test.IsPrime do
  use ExUnit.Case

  test "1 is not prime" do
    assert Epg.is_prime(1) == false
  end

  test "2 is prime" do
    assert Epg.is_prime(2) == true
  end

  test "3 is prime" do
    assert Epg.is_prime(3) == true
  end

  test "4 is not prime" do
    assert Epg.is_prime(4) == false
  end

  test "negative number returns an error" do
    assert {:error, _message} = Epg.is_prime(-1)
  end

  test "input must not be a string" do
    assert {:error, _message} = Epg.is_prime("51")
  end
end