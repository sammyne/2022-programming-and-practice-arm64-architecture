# ARM64 体系结构编程与实战

## 1. 环境
- docker 20.10.2, build 2291f61

## 2. 快速开始

### 2.1. 容器化试验环境
```bash
bash docker/dockerize.sh
```

### 2.2. 启动试验环境
```bash
bash play.sh
```

> 后续步骤在此试验环境容器内执行。

### 2.3. 运行 OS

```bash
cd mini-os
make run
```

样例输出如下
```bash
Welcome mini-os
```

### 2.4. 调试

#### 2.4.1. 构建项目
```bash
# 多次构建过程中，发现 cargo build 有时候没能察觉到 include_str 宏包含的文件变化，导致不会触发重新构建，影响调试正确性。因此，
# 清理前面的编译产物，避免被影响。
cargo clean

cargo build --release
```

#### 2.4.2. 启动被调试对象
```bash
# 具体执行的命令参见 Makefile 的 debug 目标
make debug
```

#### 2.4.3. GDB 调试
```bash
make gdb
```

上述命令会启动 GDB 远程连接到被调试对象，并在每个实验相关函数之后的 `breakpoint_hook` 函数调用前设置断点，然后执行例如借助 `i r` 命令查看相关寄存器的值等操作。

样例输出片段如下
```bash
# ...
Type "apropos word" to search for commands related to "word".
add symbol table from file "target/aarch64-unknown-none/release/mini-os"
warning: No executable has been specified and target does not support
determining executable automatically.  Try using the "file" command.
0x0000000040080010 in _start ()
The target architecture is assumed to be aarch64
Breakpoint 1 at 0x4008003c

Breakpoint 1, 0x000000004008003c in breakpoint_hook ()
x4             0x20656d6f636c6557  2334392307038315863
x5             0xa736f2d696e696d   753067803534059885
x6             0x910003df5800019e  -7998388680421015138
[Inferior 1 (process 1) exited normally]
```

各实验的输出解析解析如下
##### 实验 1
相关输出为第二个 `Breakpoint 1` 往下 3 行如下
```bash
Breakpoint 1, 0x000000004008003c in breakpoint_hook ()
x4             0x20656d6f636c6557  2334392307038315863
x5             0xa736f2d696e696d   753067803534059885
x6             0x910003df5800019e  -7998388680421015138
```

每个寄存器信息输出分为以下 3 列
1. 寄存器名称
1. 将寄存器值看做地址，解引用这个地址所得值的 16 进制形式。这个 8 字节的值编码着两条 4 字节指令，其显示采用大端编码，实际存储采用的是小端编码
```bash
寄存器名称 将寄存器值看做地址解引用所得值的16进制形式 前一列的10进制形式
```

通过 `make dump` 命令（底层调用 `aarch64-linux-gnu-objdump`）反汇编程序可得这些寄存器所存地址的相关汇编代码如下

```bash

target/aarch64-unknown-none/release/mini-os:     file format elf64-littleaarch64


Disassembly of section .rodata.cst16:

0000000040080000 <.rodata.cst16>:
    40080000:   636c6557        .inst   0x636c6557 ; undefined
    40080004:   20656d6f        .inst   0x20656d6f ; undefined
    40080008:   696e696d        ldpsw   x13, x26, [x11, #-144]
    4008000c:   0a736f2d        bic     w13, w25, w19, lsr #27

Disassembly of section .text.boot:

0000000040080010 <_start>:
    40080010:   5800019e        ldr     x30, 40080040 <breakpoint_hook+0x4>
    40080014:   910003df        mov     sp, x30
    40080018:   9400100e        bl      40084050 <LD_STACK_PTR>

# ...
```

每个符号的反汇编输出格式如下
```bash
地址：大端编码的4字节的值 汇编指令 指令参数列表
```
例如 `_start` 符号的 `40080014` 地址存储值 `910003df`，汇编指令为 `mov`，指令参数列表为 `sp, x30`。

结合上述反汇编输出，对 GDB 日志输出的样例行 `x4 0x20656d6f636c6557 2334392307038315863` 解析如下：`x1=0x40080000`，从地址 `0x40080000` 往后读取低 4 字节 `636c6557` 和高 4 字节 `20656d6f` 共 8 字节，拼接即得 `0x20656d6f636c6557`，和 GDB 调试输出的一致。

## 3. TODO
- [ ] 考虑是否实现 [Adding a little bit of Rust to AARCH64](https://krinkinmu.github.io/2020/12/13/adding-rust-to-aarch64.html) 教程的 PL011 模块。

## 4. 参考文献
- [sammyne/arm64-bare-metal-program-in-rust](https://github.com/sammyne/arm64-bare-metal-program-in-rust)
- [GDB x command](https://visualgdb.com/gdbreference/commands/x)
