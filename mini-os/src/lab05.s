  .global lab05
lab05:
  mov x1, 0x40080000
  mov x2, 0x400a0000

  add x3, x1, 32

loop:
  ldr x4, [x1], #8
  str x4, [x2], #8
  cmp x1, x3
  # ref: https://developer.arm.com/documentation/102374/0100/Program-flow---loops-and-decisions
  # ref: https://developer.arm.com/documentation/den0024/a/ARMv8-Registers/Processor-state
  # ref: https://developer.arm.com/documentation/dui0801/d/dom1359731161338
  b.cc loop

  ret
