defmodule Epg.Test.GenerateMultiplicationTable do
  use ExUnit.Case
  
  test "correct output when list = [2]" do
    assert Epg.generate_multiplication_table([2]) == [[nil, 2],
                                                      [2,   4]]
  end

  test "correct output when list = [2,3]" do
    assert Epg.generate_multiplication_table([2, 3]) == [ [nil, 2, 3],
                                                          [2,   4, 6],
                                                          [3,   6, 9]]
  end

  test "correct output when list = [2,3,5]" do
    assert Epg.generate_multiplication_table([2, 3, 5]) == [  [nil, 2,  3,    5 ],
                                                              [2,   4,  6,    10],
                                                              [3,   6,  9,    15],
                                                              [5,   10, 15,   25]]
  end

  test "correct output when list = [2,2,2]" do
    assert Epg.generate_multiplication_table([2, 2, 2]) == [[nil, 2, 2, 2],
                                                            [2,   4, 4, 4],
                                                            [2,   4, 4, 4],
                                                            [2,   4, 4, 4]]

  end

  test "correct output when list = [-2,-3] can handle negative numbers" do
    assert Epg.generate_multiplication_table([-2, -3]) == [[nil, -2, -3],
                                                           [-2,   4,  6],
                                                           [-3,   6,  9]]
  end

  test "Input list must contain all numbers" do
    assert {:error, _message} = Epg.generate_multiplication_table([2, 3, "5"])
    assert {:error, _message} = Epg.generate_multiplication_table([2, 3, []])
    assert {:error, _message} = Epg.generate_multiplication_table([2, 3, [5]])
    assert {:error, _message} = Epg.generate_multiplication_table([nil, 3, [5]])
  end

  test "Input must be a list" do
    assert {:error, _message} = Epg.generate_multiplication_table("test string")
  end
end