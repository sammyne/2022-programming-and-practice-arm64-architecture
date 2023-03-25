  .data
  .global my_data
my_data:
  .quad 0
mvar:
  .quad 0

  .text

my_atomic_write:
  adr x6, my_data

loop03:
  ldxr x2, [x6]
  mov x2, x0
  stxr w3, x2, [x6]
  cbnz w3, loop03

  mov x0, x2
  ret

atomic_set:
  mov x3, 1
  lsl x3, x3, x0

loop0303:
  ldxr x4, [x1]
  orr x4, x4, x3
  stxr w5, x4, [x1]
  cbnz w5, loop0303

  ret

  .global lab03
lab03:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  mov x0, 0x34
  bl my_atomic_write
  mov x11, x0

  mov x0, 3
  ldr x1, =mvar
  bl atomic_set
  ldr x12, mvar

  ldr x30, [sp], #16 // restore link register  
  ret
