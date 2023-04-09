  .global hello_world
hello_world:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  ldr x30, [sp], #16 // restore link register  
  ret
