  .extern func_a
  .extern func_b
  .extern func_c

  .data
name_a:
  .asciz "func_a"
name_b:
  .asciz "func_b"
name_c:
  .asciz "func_c"
name_unknown:
  .asciz "unknown"

  .text
  .global lab04
lab04:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  ldr x1, =func_a
  ldr x2, =func_b
  ldr x3, =func_c

  ldr x4, =name_a
  cmp x0, x1
  b.eq found

  ldr x4, =name_b
  cmp x0, x2
  b.eq found

  ldr x4, =name_c
  cmp x0, x3
  b.eq found

  ldr x4, =name_unknown

found:
  mov x0, x4

  ldr x30, [sp], #16 // restore link register  
  ret
