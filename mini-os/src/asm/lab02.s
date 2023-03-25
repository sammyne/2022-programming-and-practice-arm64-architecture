  .text
  .global csel_test
csel_test:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  cmp x0, xzr
  add x2, x1, 2
  sub x3, x1, 1
  # ref: # ref: https://developer.arm.com/documentation/dui0801/d/dom1359731161338
  csel x0, x2, x3, eq

  ldr x30, [sp], #16 // restore link register  
  ret

  .global lab02
lab02:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  mov x0, 0
  mov x1, 2
  bl csel_test
  mov x4, x0

  mov x0, 1
  mov x1, 2
  bl csel_test
  mov x5, x0

  ldr x30, [sp], #16 // restore link register  
  ret