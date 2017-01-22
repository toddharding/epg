defmodule Epg.Test.PrintTable do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "correct console output when input is [[nil, 2], [2, 4]]" do
    correct_output = "|    |  2 |\n|  2 |  4 |\n"
    assert capture_io(fn -> Epg.print_table([[nil, 2], [2, 4]]) end) == correct_output
  end

  test "correct output if empty list is given" do
    assert capture_io(fn -> Epg.print_table([]) end) == "table is empty\n"
  end

  test "input must be a list" do
    assert {:error, _message} = Epg.print_table(7)
  end
end