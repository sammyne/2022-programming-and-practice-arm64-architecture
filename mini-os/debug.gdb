set confirm off
add-symbol-file target/aarch64-unknown-none/release/mini-os
target remote tcp::1234
set arch aarch64
break breakpoint_hook
c
i r x4
i r x5
i r x6
c
i r x1
i r x6
i r x7
c
i r x2
i r x3
x $x2-8
x $x2
i r x4
x $x4-8
x $x4
c
quit
