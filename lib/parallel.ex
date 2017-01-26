# from http://nathanmlong.com/2014/07/pmap-in-elixir/

defmodule Parallel do

  def map(nil, _function) do
    nil
  end

  def map(collection, function) do
    this_pid = self()

    collection
    |> Enum.map( fn x ->
      spawn_link(fn ->
        spawn_pid = self()
        send(this_pid, {spawn_pid, function.(x)})
      end)
    end) |>
    Enum.map(fn (pid) ->
      receive do
        {^pid, result} -> result
      end
    end)
  end

end