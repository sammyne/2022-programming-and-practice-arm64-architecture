  .global lab02
lab02:
  # 0x40080000 是在 aarch64-qemu.ld 链接脚本定义的 mini-os 起始内存地址
  mov x1, 0x40080000

  ldr x6, [x1, #8]!

  ldr x7, [x1], #8

  ret
