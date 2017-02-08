defmodule Fib do
  def fib(0) do
    []
  end

  def fib(1) do
    [1]
  end

  def fib(2) do
    [1, 1]
  end

  def fib(n) do
    fib(n - 2, fib(2))
  end

  def fib(0, sequence) do
    sequence |> Enum.reverse
  end

  def fib(n, [h1, h2 | t] = sequence) do
    fib(n - 1, [h1 + h2 | sequence])
  end
end