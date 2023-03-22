  .data
lab04_value:
  .quad 0x5678abcd

  .text
  .global lab04
lab04:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  mov x1, 0x345

  mov x0, 0
  bfi x0, x1, 8, 4

  # mov 搬移的立即数只有两种
  # - 16 位立即数
  # - 16 位立即数左移 16、32 或者 48 位所得立即数
  ldr x2, lab04_value

  ubfx x3, x2, 4, 8
  sbfx x4, x2, 4, 8

  ldr x30, [sp], 16 // restore link register
  ret
