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
quit
