# Notes on https://elixir-lang.org/getting-started/modules-and-functions.html

import ExUnit.Assertions

# To create our own modules in Elixir, we use the defmodule macro. Inside a
# module, we can define functions with def/2 and private functions with defp/2.

defmodule Foo do
  def sum(a, b) do
    add(a, b)
  end

  defp add(a, b) do
    a + b
  end
end

assert Foo.sum(1, 2) == 3
assert(try do Foo.add(1, 2); false rescue UndefinedFunctionError -> true end)

# Compiling the code above (e.g. elixirc math.ex) will generate a file named
# Elixir.Foo.beam containing the bytecode for the defined module.

# Elixir supports the file extensions .ex and .exs: .ex files are meant to be
# compiled while .exs files are used for scripting. When executed, both
# extensions compile and load their modules into memory, although only .ex files
# write their bytecode to disk in the format of .beam files.

# Function declarations support guards and multiple clauses.
# Elixir will try each clause until it finds one that matches.

defmodule Bar do
  def zero?(0) do
    true
  end

  def zero?(x) when is_integer(x) do
    false
  end
end

assert Bar.zero?(0)
assert not Bar.zero?(1)
assert(try do Bar.zero?(2.0); false rescue FunctionClauseError -> true end)

# You can use the name/arity notation (e.g. sum/2) to retrieve a named function
# as a function type.

f = &Bar.zero?/1
assert is_function(f)
assert f.(0)

# This capture syntax can also be used as a shortcut for creating functions!
# In the example below, &1 represents the first argument.

inc1 = &(&1 + 1)
inc2 = fn x -> x + 1 end
assert inc1.(1) == 2
assert inc2.(1) == 2

# Named functions in Elixir support default arguments using the \\ syntax.
defmodule Baz do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

assert Baz.join("foo", "bar") == "foo bar"
assert Baz.join("foo", "bar", ":") == "foo:bar"
