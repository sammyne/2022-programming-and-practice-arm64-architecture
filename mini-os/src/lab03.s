  .global lab03
lab03:
  mov x2, 0x400000
  ldr x3, =0x1234abce
  str x3, [x2, #8]!

  mov x4, 0x500000
  str x3, [x4], #8

  ret
