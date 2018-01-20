# Notes on https://elixir-lang.org/getting-started/case-cond-and-if.html

import ExUnit.Assertions

# case allows us to compare a value against many patterns until we find a matching one.

t = {1, 2, 3}
r = case t do
  {4, 5, 6} -> "this won't match"
  {1, x, y} -> "matched with #{x} and #{y}"
  _ -> "default matching any other value"
end
assert r == "matched with 2 and 3"

# lauses also allow extra conditions to be specified via when guards.

r = case t do
  {1, x, 3} when rem(x, 2) == 1 -> "matched odd #{x}"
  {1, x, 3} when rem(x, 2) == 0 -> "matched even #{x}"
  _ -> "matched default"
end
assert r == "matched even 2"

# anonymous functions can also have multiple clauses and guards.

min = fn
  x, y when x < y -> x
  _, y -> y
end
assert min.(1, 2) == 1
assert min.(2, 1) == 1

# cond checks different conditions and find the first one that evaluates to true.

r = cond do
  2 + 2 == 5 -> "not true"
  2 * 2 == 3 -> "not true"
  1 + 1 == 2 -> "this one's true"
  1 * 1 == 1 -> "this one's also true"
end
assert r == "this one's true"

# If the condition given to if/2 returns false or nil, the body given between
# do/end is not executed and instead it returns nil. The opposite happens with
# unless/2.

if nil do
  raise("this won't be seen")
else
  assert true
end

unless 1 == 2 do
  assert true
end

# We can write if using Elixir’s regular syntax where each argument is separated
# by a comma. We say this syntax is using keyword lists. Keyword lists play an
# important role in the language and are quite common in many functions and macros.

r = if false, do: :alpha, else: :beta
assert r == :beta
