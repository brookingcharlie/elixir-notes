# Notes on https://elixir-lang.org/getting-started/basic-types.html

# Notice that Elixir allows you to drop the parentheses when invoking named functions.
# This feature gives a cleaner syntax when writing declarations and control-flow constructs.

IO.puts(5 == div(10, 2))
IO.puts(5 == div 10, 2)

# Single-quoted and double-quoted representations are not equivalent in Elixir
# as they are represented by different types: Single quotes are charlists,
# double quotes are strings.

IO.puts('hello' == 'hello')
IO.puts('hello' != "hello")

# An atom is a constant whose name is its own value. Some other languages call these symbols.

IO.puts(:hello == :hello)
IO.puts(:hello != 'hello')

# The booleans true and false are, in fact, atoms.

IO.puts(true == :true)
IO.puts(is_atom(true))
IO.puts(is_atom(:true))

# Anonymous functions can be created inline and are delimited by the keywords fn and end.
# Functions are “first class citizens” in Elixir meaning they can be passed as arguments
# to other functions in the same way as integers and strings.

add = fn a, b -> a + b end
IO.puts(is_function(add, 2))
IO.puts(add.(4, 5) == 9)

# Note that a dot (.) between the variable and parentheses is required to invoke
# an anonymous function. The dot ensures there is no ambiguity between calling
# an anonymous function named add and a named function add/2. In this sense,
# Elixir makes a clear distinction between anonymous functions and named functions.

app = fn f, x, y -> f.(x, y) end
IO.puts(is_function(app, 3))
IO.puts(app.(add, 4, 5) == 9)

# Elixir uses square brackets to specify a linked list of values.

xs = [1, 2, true, 3]
IO.puts(length(xs) == 4)

# List operators never modify the existing list. Concatenating to or removing elements
# from a list returns a new list. We say that Elixir data structures are immutable.

IO.puts([1, 2] ++ [3, 4] == [1, 2, 3, 4])
IO.puts(xs -- [1, true] == [2, 3])
IO.puts(xs == [1, 2, true, 3])

# Throughout the tutorial, we will talk a lot about the head and tail of a list.

IO.puts(hd(xs) == 1)
IO.puts(tl(xs) == [2, true, 3])

# When Elixir sees a list of printable ASCII numbers, Elixir will print that as
# a charlist (literally a list of characters). Charlists are quite common when
# interfacing with existing Erlang code. 

IO.puts([116, 114, 117, 101])

# Elixir uses curly brackets to define tuples. Tuples store elements contiguously
# in memory. This means accessing a tuple element by index or getting the tuple
# size is a fast operation.

t = {:ok, "hello"}
IO.puts(tuple_size(t) == 2)
IO.puts(elem(t, 0) == :ok)

# It is also possible to put an element at a particular index in a tuple with
# put_elem/3. Like lists, tuples are also immutable. Every operation on a tuple
# returns a new tuple, it never changes the given one.

u = put_elem(t, 1, "world")
IO.puts(elem(u, 1) == "world")
IO.puts(elem(t, 1) == "hello")
IO.puts(elem(u, 1) == "world")

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
