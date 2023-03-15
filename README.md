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

## 3. TODO
- [ ] 考虑是否实现 [Adding a little bit of Rust to AARCH64](https://krinkinmu.github.io/2020/12/13/adding-rust-to-aarch64.html) 教程的 PL011 模块。

## 4. 参考文献
- [sammyne/arm64-bare-metal-program-in-rust](https://github.com/sammyne/arm64-bare-metal-program-in-rust)
