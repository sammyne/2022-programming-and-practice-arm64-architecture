set confirm off
add-symbol-file target/aarch64-unknown-none/release/mini-os
target remote tcp::1234
set arch aarch64
break breakpoint_hook
c
i r x3
i r x4
i r x5
i r x6
c
i r x2
i r x3
i r x4
c
p/t $x2
p/t $x3
p/t $x4
c
p/x $x0
p/x $x3
p/x $x4
c
quit
