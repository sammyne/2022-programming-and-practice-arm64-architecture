set confirm off
add-symbol-file target/aarch64-unknown-none/release/mini-os
target remote tcp::1234
set arch aarch64
break breakpoint_hook
c
# lab01
p/x $x0
p/x $x1
p/x $x2
p/x $x3
p/x $x4
p/x $x5
c
# lab03
p/x $x11
p/x $x12
c
q
