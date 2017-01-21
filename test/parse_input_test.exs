defmodule Epg.Test.ParseInput do
  use ExUnit.Case

  test "when given the number 4, 4 is returned" do
    assert Epg.parse_input(4) == 4
  end

  test "when given the string \"4\" , the integer 4 is returned " do
    assert Epg.parse_input("4") == 4
  end

  test "an error is returned if input is character string" do
    assert {:error, _message} = Epg.parse_input("!ABC123")
  end

  test "an error is returned if input integer is negative" do
    assert {:error, _message} = Epg.parse_input(-4)
  end

  test "an error is returned if input string is parsed to negative integer" do
    assert {:error, _message} = Epg.parse_input("-4")
  end

  test "an error is returned if in a string the number is formatted incorrectly and cannot be parsed" do
    assert {:error, _message} = Epg.parse_input("5 6")
  end
end