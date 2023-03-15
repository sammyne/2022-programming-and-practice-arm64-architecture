
app = target/aarch64-unknown-none/release/mini-os

srcs = $(shell find src)

.PHONY: all
all: $(app)

$(app): .cargo $(srcs) aarch64-qemu.ld aarch64-unknown-none.json Cargo.toml toolchain.toml
	@cargo clean
	@cargo build --release

gdb: debug.gdb
	@gdb-multiarch -x debug.gdb

dump: $(app)
	@aarch64-linux-gnu-objdump -D $<

run: $(app)
	@qemu-system-aarch64 															\
		-M virt 																				\
		-m 1024M 																				\
		-cpu cortex-a72 																\
		-nographic 																			\
		-kernel $<

debug: $(app)
	@qemu-system-aarch64 															\
		-machine virt 																	\
		-m 1024M 																				\
		-cpu cortex-a72 																\
		-nographic 																			\
		-kernel $< 																			\
		-S -s

.PHONY: clean
clean:
	@cargo clean
