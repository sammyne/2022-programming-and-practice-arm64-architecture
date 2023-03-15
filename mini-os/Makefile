
app = target/aarch64-unknown-none/release/mini-os

.PHONY: all
all: $(app)

$(app): .cargo src aarch64-qemu.ld aarch64-unknown-none.json Cargo.toml toolchain.toml
	cargo build --release

debug: debug.gdb
	gdb-multiarch -x debug.gdb

dump: $(app)
	@aarch64-linux-gnu-objdump -D $<

run: $(app)
	@qemu-system-aarch64 															\
		-M virt 																				\
		-m 1024M 																				\
		-cpu cortex-a72 																\
		-nographic 																			\
		-kernel $<

serve-for-debug: $(app)
	qemu-system-aarch64 															\
		-machine virt 																	\
		-m 1024M 																				\
		-cpu cortex-a72 																\
		-nographic 																			\
		-kernel $< 																			\
		-S -s

.PHONY: clean
clean:
	@cargo clean
