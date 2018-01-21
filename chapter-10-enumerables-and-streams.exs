# Notes on https://elixir-lang.org/getting-started/enumerables-and-streams.html

import ExUnit.Assertions

# Elixir provides the concept of enumerables and the Enum module to work with them.
# The Enum module provides a huge range of functions to transform, sort, group,
# filter and retrieve items from enumerables. It is one of the modules developers
# use frequently in their Elixir code.

assert Enum.map([1, 2, 3], fn x -> x * 2 end) == [2, 4, 6]
assert Enum.map(%{1 => 2, 3 => 4}, fn {k, v} -> k * v end) == [2, 12]

# Functions in the Enum module can work with any data type that implements the
# Enumerable protocol. Elixir also provides ranges.

assert Enum.reduce(1..3, 0, &+/2) == 6

# All the functions in the Enum module are eager. Many functions expect an
# enumerable and return a list back. In the piped example below, each operation
# generates an intermediate list until we read the result.

assert (1..5 |> Enum.map(&(&1 * 2)) |> Enum.sum) == 30

# The |> symbol used in the snippet above is the pipe operator: it takes the
# output from the expression on its left side and passes it as the first
# argument to the function call on its right side. To see how it can make the
# code cleaner, have a look at our example rewritten without the |> operator.

assert Enum.sum(Enum.map(1.. 5, &(&1 * 2))) == 30

# As an alternative to Enum, Elixir provides the Stream module which supports
# lazy operations. Streams are lazy, composable enumerables. Instead of
# generating intermediate lists, streams build a series of computations that are
# invoked only when we pass the underlying stream to the Enum module.
# Streams are useful when working with large, possibly infinite, collections.

assert (1..5 |> Stream.map(&(&1 * 2)) |> Enum.sum) == 30
