set confirm off
add-symbol-file target/aarch64-unknown-none/release/mini-os
target remote tcp::1234
set arch aarch64
break breakpoint_hook
c
p $x0
c
c
p $x0
c
q
