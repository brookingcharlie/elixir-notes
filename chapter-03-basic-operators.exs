# Notes on https://elixir-lang.org/getting-started/basic-operators.html

# String concatenation is done with <>.

IO.puts("foo" <> "bar" == "foobar")

# Elixir also provides three boolean operators: or, and and not.

IO.puts(true and not false)
IO.puts(false or is_atom(:example))

# or and and are short-circuit operators. They only execute the right side if
# the left side is not enough to determine the result
IO.puts(true or raise("This error will never be raised"))

# and, or, and not are strict in the sense that they expect a boolean (true or
# false) as their first argument.
#
# Besides these boolean operators, Elixir also provides ||, && and ! which
# accept arguments of any type. For these operators, all values except false
# and nil will evaluate to true.

IO.puts((1 || true) == 1)
IO.puts((false || 11) == 11)
IO.puts((nil && 13) == nil)
IO.puts((true && 17) == 17)
IO.puts(!true == false)
IO.puts(!1 == false)

# Elixir also provides ==, !=, ===, !==, <=, >=, <, and > as comparison operators.

IO.puts(1 == 1)
IO.puts(1 != 2)
IO.puts(1 < 2)

# The difference between == and === is that the latter is more strict when
# comparing integers and floats

IO.puts(1 == 1.0)
IO.puts(not(1 === 1.0))
IO.puts(1 !== 1.0)

# In Elixir, we can compare two different data types.
# The reason we can compare different data types is pragmatism - so sorting
# algorithms don’t need to worry about different data types in order to sort.
# The overall sorting order is defined as:
# number < atom < reference < function < port < pid < tuple < map < list < bitstring

IO.puts(1 < :atom)
