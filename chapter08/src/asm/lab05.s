  .text
add_1:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  add x0, x0, x1
  add x0, x0, 1

  ldr x30, [sp], #16 // restore link register  
  ret

add_2:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  add x0, x0, x1
  add x0, x0, 2

  ldr x30, [sp], #16 // restore link register  
  ret

  .macro madd a:req, b:req, label:req
  mov x0, \a
  mov x1, \b
  bl add\()_\label
  .endm

  .global lab05
lab05:
  str x30, [sp, #-16]! // save link register to avoid corrpution by bl

  madd 1, 2, 1
  mov x3, x0

  madd 1, 2, 2
  mov x4, x0

  ldr x30, [sp], #16 // restore link register  
  ret
