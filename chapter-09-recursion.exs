# Notes on https://elixir-lang.org/getting-started/recursion.html

import ExUnit.Assertions

# Recursion and tail call optimization are an important part of Elixir and are
# commonly used to create loops.

defmodule Recursion do
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)
end

assert Recursion.sum([1, 2, 3, 4]) == 10

# However, when programming in Elixir you will rarely use recursion as above to
# manipulate lists. The Enum module already provides many convenient functions.

sum = fn xs -> Enum.reduce(xs, 0, &(&1 + &2)) end

assert sum.([1, 2, 3, 4]) == 10
