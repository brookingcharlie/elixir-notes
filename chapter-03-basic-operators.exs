# Notes on https://elixir-lang.org/getting-started/basic-operators.html

import ExUnit.Assertions

# String concatenation is done with <>.

assert "foo" <> "bar" == "foobar"

# Elixir also provides three boolean operators: or, and and not.

assert true and not false
assert false or is_atom(:example)

# or and and are short-circuit operators. They only execute the right side if
# the left side is not enough to determine the result
assert true or raise("This error will never be raised")

# and, or, and not are strict in the sense that they expect a boolean (true or
# false) as their first argument.
#
# Besides these boolean operators, Elixir also provides ||, && and ! which
# accept arguments of any type. For these operators, all values except false
# and nil will evaluate to true.

assert (1 || true) == 1
assert (false || 11) == 11
assert (nil && 13) == nil
assert (true && 17) == 17
assert !true == false
assert !1 == false

# Elixir also provides ==, !=, ===, !==, <=, >=, <, and > as comparison operators.

assert 1 == 1
assert 1 != 2
assert 1 < 2

# The difference between == and === is that the latter is more strict when
# comparing integers and floats

assert 1 == 1.0
assert not(1 === 1.0)
assert 1 !== 1.0

# In Elixir, we can compare two different data types.
# The reason we can compare different data types is pragmatism - so sorting
# algorithms don’t need to worry about different data types in order to sort.
# The overall sorting order is defined as:
# number < atom < reference < function < port < pid < tuple < map < list < bitstring

assert 1 < :atom
