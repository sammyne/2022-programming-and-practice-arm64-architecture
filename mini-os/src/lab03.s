  .global lab03
lab03:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  mov x0, 1
  mov x1, 0xffffffffffffffff

  ands xzr, xzr, xzr
  // nzcv 寄存器标记位布局为
  // 比特下标：63-32 | 31 | 30 | 29 | 28 | 27-0
  //   标记位： RES0 | N  | Z  | C  | V  | RES0
  mrs x2, nzcv
  lsr x2, x2, 28

  ands xzr, x0, x1
  mrs x3, nzcv
  lsr x3, x3, 28

  // carry flag is unset
  ands xzr, x0, x1, lsr #1
  mrs x4, nzcv
  lsr x4, x4, 28

  ldr x30, [sp], #16 // restore link register

  ret