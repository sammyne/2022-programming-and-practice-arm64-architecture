my_label:
  .quad 0x20

  .global lab04
lab04:
  ldr x6, my_label
  ldr x7, =my_label

  ret
