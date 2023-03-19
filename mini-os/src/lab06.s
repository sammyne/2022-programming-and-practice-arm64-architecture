  .global lab06_memset_aligned_16bytes
lab06_memset_aligned_16bytes:
  mov x4, #0

loop06:
	stp x1, x1, [x0], #16
	add x4, x4, #16
	cmp x4, x2
	bne loop06

	ret