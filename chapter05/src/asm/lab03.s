  .extern csel_test

  .global lab03
lab03:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  mov x0, 1
  mov x1, 2

  bl csel_test

  ldr x30, [sp], #16 // restore link register  
  ret
