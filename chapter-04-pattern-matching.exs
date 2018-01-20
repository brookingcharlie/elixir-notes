# Notes on https://elixir-lang.org/getting-started/pattern-matching.html

import ExUnit.Assertions

{a, b} = {:hello, "world"}
assert a == :hello
assert b == "world"

[a, b] = [1, 2]
assert a == 1
assert b == 2

[head | tail] = [1, 2, 3]
assert head == 1
assert tail == [2, 3]

# The [head | tail] format is not only used on pattern matching but also for
# prepending items to a list.

xs = [2, 3]
assert [1 | xs] == [1, 2, 3]

# Use the pin operator ^ when you want to pattern match against an existing
# variable’s value rather than rebinding (i.e. reassigning) the variable.

x = 1
{y, ^x} = {2, 1}
assert y == 2

# In some cases, you don’t care about a particular value in a pattern. It is a
# common practice to bind those values to the underscore, _. The variable _ is
# special in that it can never be read from. Trying to read from it gives an
# unbound variable error

[h | _] = [1, 2, 3]
{_, y, _} = {1, 2, 3}
assert h == 1
assert y == 2
