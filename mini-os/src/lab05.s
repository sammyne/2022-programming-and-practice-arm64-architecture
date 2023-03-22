  .global lab05
lab05:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  # ref: https://developer.arm.com/documentation/ddi0595/2020-12/AArch64-Registers/ID-AA64ISAR0-EL1--AArch64-Instruction-Set-Attribute-Register-0
  mrs x1, id_aa64isar0_el1

  ubfx x0, x1, 20, 4

  ubfx x2, x1, 4, 4

  ldr x30, [sp], 16 // restore link register
  ret
