  .text
  .global lab02
lab02:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  cmp x0, x1
  csel x0, x0, x1, ge

  ldr x30, [sp], #16 // restore link register  
  ret
