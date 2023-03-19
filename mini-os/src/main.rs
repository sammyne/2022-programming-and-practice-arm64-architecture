#![no_std]
#![no_main]

use core::arch::global_asm;
use core::panic::PanicInfo;

use mini_os::pl011;

global_asm!(include_str!("start.s"));

global_asm!(include_str!("lab01.s"));
global_asm!(include_str!("lab02.s"));
global_asm!(include_str!("lab03.s"));
global_asm!(include_str!("lab04.s"));
global_asm!(include_str!("lab05.s"));
global_asm!(include_str!("lab06.s"));

global_asm!(include_str!("breakpoint_hook.s"));

extern "C" {
    fn lab01();
    fn lab02();
    fn lab03();
    fn lab04();
    fn lab05();
    fn lab06_memset_aligned_16bytes(s: *mut u8, data: u64, count: u64);

    fn breakpoint_hook();
}

#[panic_handler]
fn on_panic(_info: &PanicInfo) -> ! {
    loop {}
}

#[no_mangle]
pub extern "C" fn not_main() {
    let out_str = b"Welcome mini-os\n";
    pl011::write(out_str);

    unsafe {
        lab01();
        breakpoint_hook(); // 添加钩子函数辅助断点调试

        lab02();
        breakpoint_hook(); // 添加钩子函数辅助断点调试

        lab03();
        breakpoint_hook(); // 添加钩子函数辅助断点调试

        lab04();
        breakpoint_hook(); // 添加钩子函数辅助断点调试

        lab05();
        breakpoint_hook(); // 添加钩子函数辅助断点调试

        // FIXME: this is buggy for unknown reasons
        //let mut buf = [0u8; 32];
        
        let buf = 0x400b0000u64 as *mut u8;
        let _ = memset_impl(buf, 123, 15);
    }
}

unsafe fn memset_aligned_1byte(buf: *mut u8, v: u8, n: u64) {
    let mut b = buf;
    for _i in 0..n {
        *b = v;
        b = b.offset(1);
    }
}

unsafe fn memset_impl(buf: *mut u8, v: u8, nbuf: u64) -> *mut u8 {
    const ALIGN: u64 = 16;

    let mut p = buf;
    let addr = p as u64;
    let mut remaining = nbuf;

    if (addr & (ALIGN - 1)) != 0 {
        let unaligned_len = ALIGN - (addr & (ALIGN - 1));
        memset_aligned_1byte(p, v, unaligned_len);
        p = p.offset(unaligned_len as isize);
        remaining -= unaligned_len;
    }

    let data = {
        let mut out: u64 = 0;
        let vv = v as u64;

        for _i in 0..8 {
            out = (out << 8) | vv;
        }
        out
    };

    if remaining >= ALIGN {
        lab06_memset_aligned_16bytes(p, data, remaining / ALIGN);
    }

    buf
}
