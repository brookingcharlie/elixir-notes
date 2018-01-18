# Notes on https://elixir-lang.org/getting-started/pattern-matching.html

{a, b, c} = {:hello, "world", 42}
IO.puts(a == :hello)
IO.puts(c == 42)

[a, b, c] = [1, 2, 3]
IO.puts(b == 2)

[head | tail] = [1, 2, 3]
IO.puts(head == 1)
IO.puts(tail == [2, 3])

# The [head | tail] format is not only used on pattern matching but also for
# prepending items to a list.

xs = [2, 3]
IO.puts([1 | xs] == [1, 2, 3])

# Use the pin operator ^ when you want to pattern match against an existing
# variable’s value rather than rebinding (i.e. reassigning) the variable.

x = 1
{y, ^x} = {2, 1}
IO.puts(y == 2)

# In some cases, you don’t care about a particular value in a pattern. It is a
# common practice to bind those values to the underscore, _. The variable _ is
# special in that it can never be read from. Trying to read from it gives an
# unbound variable error

[h | _] = [1, 2, 3]
IO.puts(h == 1)
