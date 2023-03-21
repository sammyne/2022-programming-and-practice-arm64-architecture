  .global lab01
lab01:
  mov x1, 0xffffffffffffffff
  mov x2, 1

  adds xzr, x1, x2

  adc x3, xzr, xzr

  mov x1, 1
  mov x2, 2

  cmp x1, x2
  adc x4, xzr, xzr

  cmp x2, x2
  adc x5, xzr, xzr

  cmp x2, x1
  adc x6, xzr, xzr
  
  ret
