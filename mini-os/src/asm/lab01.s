  .extern init_pg_dir

  .data
  .align 3
my_test_data:
  .dword 0x12345678abcdabcd

  .text
  .global lab01
lab01:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  adr x0, my_test_data
  adrp x1, my_test_data

  ldr x2, =my_test_data
  ldr x3, my_test_data

  adrp x4, init_pg_dir
  ldr x5, =init_pg_dir

  ldr x30, [sp], #16 // restore link register  
  ret
