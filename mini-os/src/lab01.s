  .global lab01
lab01:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

# 练习 1
  mov x1, 1
  mov x2, -3

loop0101:
  cmn x1, x2
   // nzcv 寄存器标记位布局为
  // 比特下标：63-32 | 31 | 30 | 29 | 28 | 27-0
  //   标记位： RES0 | N  | Z  | C  | V  | RES0
  mrs x3, nzcv
  lsr x3, x3, 28
  # ref: https://developer.arm.com/documentation/dui0801/d/dom1359731161338
  b.ge done0101
  add x2, x2, 1
  b loop0101

done0101:

# 练习 2
  mov x1, 1
  mov x2, 3

loop0102:
  cmp x1, x2
   // nzcv 寄存器标记位布局为
  // 比特下标：63-32 | 31 | 30 | 29 | 28 | 27-0
  //   标记位： RES0 | N  | Z  | C  | V  | RES0
  mrs x3, nzcv
  lsr x3, x3, 28
  # ref: https://developer.arm.com/documentation/dui0801/d/dom1359731161338
  b.ge done0102
  add x1, x1, 1
  b loop0102

done0102:

  ldr x30, [sp], #16 // restore link register  
  ret
