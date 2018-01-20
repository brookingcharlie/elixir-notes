# Notes on https://elixir-lang.org/getting-started/basic-types.html

import ExUnit.Assertions

# Notice that Elixir allows you to drop the parentheses when invoking named functions.
# This feature gives a cleaner syntax when writing declarations and control-flow constructs.

assert 5 == div(10, 2)
assert 5 == div 10, 2

# Single-quoted and double-quoted representations are not equivalent in Elixir
# as they are represented by different types: Single quotes are charlists,
# double quotes are strings.

assert 'hello' == 'hello'
assert 'hello' != "hello"

# An atom is a constant whose name is its own value. Some other languages call these symbols.

assert :hello == :hello
assert :hello != 'hello'

# The booleans true and false are, in fact, atoms.

assert true == :true
assert is_atom(true)
assert is_atom(:true)

# Anonymous functions can be created inline and are delimited by the keywords fn and end.
# Functions are “first class citizens” in Elixir meaning they can be passed as arguments
# to other functions in the same way as integers and strings.

add = fn a, b -> a + b end
assert is_function(add, 2)
assert add.(4, 5) == 9

# Note that a dot (.) between the variable and parentheses is required to invoke
# an anonymous function. The dot ensures there is no ambiguity between calling
# an anonymous function named add and a named function add/2. In this sense,
# Elixir makes a clear distinction between anonymous functions and named functions.

app = fn f, x, y -> f.(x, y) end
assert is_function(app, 3)
assert app.(add, 4, 5) == 9

# Elixir uses square brackets to specify a linked list of values.

xs = [1, 2, true, 3]
assert length(xs) == 4

# List operators never modify the existing list. Concatenating to or removing elements
# from a list returns a new list. We say that Elixir data structures are immutable.

assert [1, 2] ++ [3, 4] == [1, 2, 3, 4]
assert xs -- [1, true] == [2, 3]
assert xs == [1, 2, true, 3]

# Throughout the tutorial, we will talk a lot about the head and tail of a list.

assert hd(xs) == 1
assert tl(xs) == [2, true, 3]

# When Elixir sees a list of printable ASCII numbers, Elixir will print that as
# a charlist (literally a list of characters). Charlists are quite common when
# interfacing with existing Erlang code. 

assert [116, 114, 117, 101] == 'true'

# Elixir uses curly brackets to define tuples. Tuples store elements contiguously
# in memory. This means accessing a tuple element by index or getting the tuple
# size is a fast operation.

t = {:ok, "hello"}
assert tuple_size(t) == 2
assert elem(t, 0) == :ok

# It is also possible to put an element at a particular index in a tuple with
# put_elem/3. Like lists, tuples are also immutable. Every operation on a tuple
# returns a new tuple, it never changes the given one.

u = put_elem(t, 1, "world")
assert elem(u, 1) == "world"
assert elem(t, 1) == "hello"
assert elem(u, 1) == "world"

# Lists are stored in memory as linked lists, meaning that each element in a list
# holds its value and points to the following element until the end of the list
# is reached. This means accessing the length of a list is a linear operation: we
# need to traverse the whole list in order to figure out its size.
#
# Tuples, on the other hand, are stored contiguously in memory. This means
# getting the tuple size or accessing an element by index is fast. However,
# updating or adding elements to tuples is expensive because it requires creating
# a new tuple in memory
#
# Most of the time, Elixir is going to guide you to do the right thing. For
# example, there is an elem/2 function to access a tuple item but there is no
# built-in equivalent for lists
#
# When counting the elements in a data structure, Elixir also abides by a simple
# rule: the function is named size if the operation is in constant time (i.e.
# the value is pre-calculated) or length if the operation is linear (i.e.
# calculating the length gets slower as the input grows). As a mnemonic, both
# “length” and “linear” start with “l”.
