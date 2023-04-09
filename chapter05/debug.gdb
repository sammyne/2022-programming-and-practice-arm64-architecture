set confirm off
add-symbol-file target/aarch64-unknown-none/release/mini-os
target remote tcp::1234
set arch aarch64
break breakpoint_hook
break loop0101
break loop0102
c
# usage ref: https://web.mit.edu/gnu/doc/html/gdb_10.html#SEC59
display $x2
display/t $x3
c
c
c
undisplay 1-2

display $x1
display/t $x3
c
c
c
undisplay 3-4

c
p $x4
p $x5
c
p $x0
c
q
