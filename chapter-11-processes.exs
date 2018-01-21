# Notes on https://elixir-lang.org/getting-started/processes.html

import ExUnit.Assertions

# In Elixir, all code runs inside processes. Processes are isolated from each
# other, run concurrent to one another and communicate via message passing.
#
# Elixir’s processes should not be confused with operating system processes.
# Processes in Elixir are extremely lightweight in terms of memory and CPU
# (unlike threads in many other programming languages). Because of this, it is
# not uncommon to have tens or even hundreds of thousands of processes running
# simultaneously.

# The basic mechanism for spawning new processes is the auto-imported spawn/1.

pid = spawn fn -> 1 + 2 end

assert is_pid(pid)

# We can retrieve the PID of the current process by calling self/0.

assert is_pid(self())
assert Process.alive?(self())

# We can send messages to a process with send/2 and receive them with receive/1.
# When a message is sent to a process, the message is stored in the process mailbox.
# The process that sends the message does not block on send/2, it puts the message
# in the recipient’s mailbox and continues.

send self(), {:hello, "hello, world"}

# The receive/1 block goes through the current process mailbox searching for a
# message that matches any of the given patterns. receive/1 supports guards and
# many clauses making it similar to case/2.

msg =
  receive do
    {:hello, m} -> m
    {:goodbye, _} -> "won't match"
  after 1000 -> "nothing after 1 second"
  end

assert msg == "hello, world"

# The example below shows communication between two process (child to parent).

parent = self()
spawn fn -> send(parent, {:hello, "Hello from child"}) end
msg = receive do {:hello, m} -> m end

assert msg == "Hello from child"

# When unlinked processes raise an error, the parent continued as normal.
# With linked processes, errors are propagated.

Process.flag(:trap_exit, true)

spawn fn -> raise "oops" end
# 21:35:19.542 [error] Process #PID<0.78.0> raised an exception
# ** (RuntimeError) oops
#     chapter-11-processes.exs:58: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
assert not (receive do {:EXIT, _, _} -> true after 100 -> false end)

spawn_link fn -> raise "oops" end
# 21:35:19.643 [error] Process #PID<0.79.0> raised an exception
# ** (RuntimeError) oops
#     chapter-11-processes.exs:61: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
assert(receive do {:EXIT, _, _} -> true after 100 -> false end)

# Processes and links play an important role when building fault-tolerant systems.
# Elixir processes are isolated and don’t share anything by default. Therefore, a
# failure in a process will never crash or corrupt the state of another process.
# Links, however, allow processes to establish a relationship in a case of
# failures. We often link our processes to supervisors which will detect when a
# process dies and start a new process in its place.
#
# While other languages would require us to catch/handle exceptions, in Elixir we
# are actually fine with letting processes fail because we expect supervisors to
# properly restart our systems. “Failing fast” is a common philosophy when writing
# Elixir software!

# Tasks build on top of the spawn functions to provide better error reports and
# introspection. Instead of spawn/1 and spawn_link/1, we use Task.start/1 and
# Task.start_link/1 which return {:ok, pid} rather than just the PID. This is
# what enables tasks to be used in supervision trees. Furthermore, Task provides
# convenience functions, like Task.async/1 and Task.await/1, and functionality to
# ease distribution.

Task.start fn -> raise "oops" end
# 21:35:19.644 [error] Task #PID<0.80.0> started from #PID<0.73.0> terminating
# ** (RuntimeError) oops
#     chapter-11-processes.exs:79: anonymous fn/0 in :elixir_compiler_0.__FILE__/1
#     (elixir) lib/task/supervised.ex:85: Task.Supervised.do_apply/2
#     (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
# Function: #Function<4.100873718/0 in :elixir_compiler_0.__FILE__/1>
#     Args: []
