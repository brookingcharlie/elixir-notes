# Notes on https://elixir-lang.org/getting-started/io-and-the-file-system.html

# The IO module is the main mechanism in Elixir for reading and writing to
# standard input/output (:stdio), standard error (:stderr), files, and other IO
# devices.
#
#   iex> IO.puts "hello world"
#   hello world
#   :ok
#
#   iex> IO.gets "yes or no? "
#   yes or no? yes
#   "yes\n"
#
#   iex> IO.puts :stderr, "hello world"
#   hello world
#   :ok

# The File module contains functions that allow us to open files as IO devices.
#
# By default, files are opened in binary mode, which requires developers to use
# the specific IO.binread/2 and IO.binwrite/2 functions from the IO module
# A file can also be opened with :utf8 encoding, which tells the File module to
# interpret the bytes read from the file as UTF-8-encoded bytes.
#
#   iex> {:ok, file} = File.open "hello", [:write]
#   {:ok, #PID<0.47.0>}
#
#   iex> IO.binwrite file, "world"
#   :ok
#
#   iex> File.close file
#   :ok
#
#   iex> File.read "hello"
#   {:ok, "world"}
#
# Besides functions for opening, reading and writing files, the File module has
# many functions to work with the file system. Those functions are named after
# their UNIX equivalents. For example, File.rm/1 can be used to remove files,
# File.mkdir/1 to create directories, File.mkdir_p/1 to create directories and
# all their parent chain.
#
# You will also notice that functions in the File module have two variants: one
# “regular” variant and another variant with a trailing bang (!). For example,
# when we read the "hello" file in the example above, we use File.read/1.
# Alternatively, we can use File.read!/1:
#
#   iex> File.read "hello"
#   {:ok, "world"}
#
#   iex> File.read! "hello"
#   "world"
#
#   iex> File.read "unknown"
#   {:error, :enoent}
#
#   iex> File.read! "unknown"
#   ** (File.Error) could not read file "unknown": no such file or directory

# The majority of the functions in the File module expect paths as arguments.
# Most commonly, those paths will be regular binaries. The Path module provides
# facilities for working with such paths:
#
#   iex> Path.join("foo", "bar")
#   "foo/bar"
#
#   iex> Path.expand("~/hello")
#   "/Users/jose/hello"
