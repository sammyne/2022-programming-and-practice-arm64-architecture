  .extern printf

  .data
arr:
  .quad 1
  .quad 3
  .quad 2
arr_len:
  .quad 3

  .text
// x0: arr address
// x1: arr length
max1:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  ldr x20, [x0]
loop:
  ldr x21, [x0], 8  
  cmp x20, x21
  # ref: https://developer.arm.com/documentation/dui0801/d/dom1359731161338
  csel x20, x20, x21, ge
  sub x1, x1, 1 
  cmp x1, xzr
  b.ne loop

  mov x0, x20

  ldr x30, [sp], #16 // restore link register  
  ret

  .global lab01
lab01:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  ldr x0, =arr
  ldr x1, arr_len
  bl max1

  ldr x30, [sp], #16 // restore link register  
  ret
