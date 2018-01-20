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
#

# The following are all the same statement. In general, when the keyword list is
# the last argument of a function, the square brackets are optional.

assert (if false do "foo" else "bar" end) == "bar"
assert (if false, do: "foo", else: "bar") == "bar"
assert if(false, [do: "foo", else: "bar"]) == "bar"
assert if(false, [{:do, "foo"}, {:else, "bar"}]) == "bar"

# Although we can pattern match on keyword lists, it is rarely done in practice
# since pattern matching on lists requires the number and order of items to match.
#
#   iex> [a: a] = [a: 1]
#   [a: 1]
#   iex> [a: a] = [a: 1, b: 2]
#   ** (MatchError) no match of right hand side value: [a: 1, b: 2]
#   iex> [b: b, a: a] = [a: 1, b: 2]
#   ** (MatchError) no match of right hand side value: [a: 1, b: 2]
#

# Keyword lists are used in Elixir mainly for passing optional values. If you
# need to store many items (i.e. need better than linear performance of lists)
# or guarantee one key associates with at most one-value, use maps instead.

m1 = %{:a => 1, :b => 2}
assert m1[:a] == 1
assert m1[:b] == 2

# Compared to keyword lists have these properties:
#
# * Maps allow any value as a key.
# * Maps’ keys do not follow any ordering.
#
# You can use a variety of syntaxes/functions when working with maps,
# particularly a special dot-field syntax when keys are atoms.

m2 = %{:a => 1, :b => 2}
m2 = Map.put(m2, :c, 3)
m2 = Map.put(m2, :a, 4)
m2 = %{m2 | :b => 6} # updates existing keys only
assert m2[:a] == 4
assert m2.b == 6
assert Map.get(m2, :c) == 3

# In contrast to keyword lists, maps are very useful with pattern matching.
# When a map is used in a pattern, it's matched on a subset of the given value.

%{1 => x} = %{1 => "foo", 2 => "bar"}
assert x == "foo"

# Often we will have maps inside maps, or even keywords lists inside maps, and
# so forth. Elixir provides conveniences for manipulating nested data structures
# via the put_in/2, update_in/2 and other macros giving the same conveniences
# you would find in imperative languages while keeping the immutable properties
# of the language. For more info, see <https://hexdocs.pm/elixir/Kernel.html>.

users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]

users = put_in users[:john].age, 31
assert users[:john].age == 31

users = update_in users[:mary].languages, fn languages -> List.delete(languages, "Clojure") end
assert users[:mary].languages == ["Elixir", "F#"]
