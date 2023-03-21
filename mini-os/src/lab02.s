  .global compare_and_return
compare_and_return:
  cmp x0, x1

  sbc x0, xzr, xzr

  ret

  .global lab02
lab02:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  mov x0, 0
  mov x1, 1
  bl compare_and_return
  mov x2, x0


  mov x0, 1
  mov x1, 1
  bl compare_and_return
  mov x3, x0

  mov x0, 1
  mov x1, 0
  bl compare_and_return
  mov x4, x0

  ldr x30, [sp], #16 // restore link register

  ret
