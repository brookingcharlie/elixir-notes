# Notes on https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html

import ExUnit.Assertions

# Elixir chose the UTF-8 encoding as its main and default encoding.

s1 = "hello"
s2 = "hełło"
assert String.length(s1) == 5
assert String.length(s2) == 5
assert byte_size(s1) == 5
assert byte_size(s2) == 7

# In Elixir, you can define a binary (a sequence of bytes) using <<>>:

b1 = <<0, 1, 2, 3>>
assert byte_size(b1) == 4

# The string concatenation operation is actually a binary concatenation operator.

b2 = <<0, 1>> <> <<2, 3>>
assert byte_size(b2) == 4

# Each number given to a binary is meant to represent a byte and therefore must
# go up to 255. Binaries allow modifiers to be given to store numbers bigger
# than 255 or to convert a code point to its UTF-8 representation

b3 = <<255, 256>>
b4 = <<255, 256 :: size(16)>>
assert b3 == <<255, 0>>
assert b4 == <<255, 1, 0>>
assert bit_size(b3) == 16
assert bit_size(b4) == 24

# A binary is a bitstring where the number of bits is divisible by 8.
# But if we set sizes not divisible by 8, we get bitstsrings rather than binaries.

b5 = <<1 :: size(16)>>
b6 = <<1 :: size(1)>>
assert is_binary(b5)
assert is_bitstring(b6)
assert bit_size(b6) == 1

# We can also pattern match on binaries / bitstrings.

<<1, x, 3>> = <<1, 2, 3>>
"he" <> y = "hello"
assert x == 2
assert y == "llo"

# A charlist is nothing more than a list of code points. Char lists may be
# created with single-quoted literals

c1 = 'hełło'
assert c1 == [104, 101, 322, 322, 111]
assert is_list(c1)

# In practice, charlists are used mostly when interfacing with Erlang, in
# particular old libraries that do not accept binaries as arguments. You can
# convert a charlist to a string and back by using the to_string/1 and
# to_charlist/1 functions

assert to_charlist("hełło") == c1
assert to_string(c1) == "hełło"
