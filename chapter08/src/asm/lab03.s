  .extern max3
  .text
  .global lab03
lab03:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  mov x0, 123
  mov x1, 456

  bl max3

  ldr x30, [sp], #16 // restore link register  
  ret
