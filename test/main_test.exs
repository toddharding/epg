defmodule Epg.Test.Main do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "main func outputs correctly when 1 is entered" do
    correct_output = "|    |  2 |\n|  2 |  4 |\n"
    assert capture_io(fn -> Epg.main(["1"]) end) == correct_output
  end

  test "main func outputs correctly when 2 is entered" do
    correct_output = "|    |  2 |  3 |\n|  2 |  4 |  6 |\n|  3 |  6 |  9 |\n"
    assert capture_io(fn -> Epg.main(["2"]) end) == correct_output
  end

end