# Notes on https://elixir-lang.org/getting-started/keywords-and-maps.html

import ExUnit.Assertions

# In many functional programming languages, it is common to use a list of 2-item
# tuples as the representation of a key-value data structure. In Elixir, when we
# have a list of tuples and the first item of the tuple (i.e. the key) is an
# atom, we call it a keyword list. As you can see above, Elixir supports a
# special syntax for defining such lists: [key: value].

k1 = [{:a, 1}, {:b, 2}]
k2 = [a: 1, b: 2]
assert k1 == k2

# Since keyword lists are lists, we can use all operations available to lists.
# For example, we can use ++ to add new values to a keyword list

k3 = k2 ++ [c: 3]
assert k3 == [a: 1, b: 2, c: 3]

# Note that values added to the front are the ones fetched on lookup.

k4 = [a: 0] ++ k1
assert k4 == [a: 0, a: 1, b: 2]
assert k4[:a] == 0

# Keyword lists are important because they have three special characteristics:
#
# * Keys must be atoms.
# * Keys are ordered, as specified by the developer.
# * Keys can be given more than once.
#
# Keyword lists were chosen as the default mechanism for passing options in
# Elixir since they enable nice DSLs like this Ecto example:
#
#   query = from w in Weather,
#     where: w.prcp > 0,
#     where: w.temp < 20,
#     select: w

# The following are all the same statement. In general, when the keyword list is
# the last argument of a function, the square brackets are optional.

assert (if false do "foo" else "bar" end) == "bar"
assert (if false, do: "foo", else: "bar") == "bar"
assert if(false, [do: "foo", else: "bar"]) == "bar"
assert if(false, [{:do, "foo"}, {:else, "bar"}]) == "bar"

# Keyword lists are used in Elixir mainly for passing optional values. If you
# need to store many items (i.e. need better than linear performance of lists)
# or guarantee one key associates with at most one-value, use maps instead.

# Whenever you need a key-value store, maps are the “go to” data structure in Elixir.

m = %{:a => 1, :b => 2}
assert m[:a] == 1
assert m[:b] == 2
