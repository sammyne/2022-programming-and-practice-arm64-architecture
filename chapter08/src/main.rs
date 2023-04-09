#![no_std]
#![no_main]

use core::arch::global_asm;
use core::ffi::{c_char, CStr};
use core::panic::PanicInfo;

use mini_os::pl011;

global_asm!(include_str!("asm/start.s"));

//global_asm!(include_str!("asm/hello_world.s"));
global_asm!(include_str!("asm/lab01.s"));
global_asm!(include_str!("asm/lab02.s"));
global_asm!(include_str!("asm/lab03.s"));
global_asm!(include_str!("asm/lab04.s"));

global_asm!(include_str!("asm/breakpoint_hook.s"));

extern "C" {
    // fn hello_world();
    fn lab01();
    fn lab02(a: u64, b: u64);
    fn lab03();
    fn lab04(func_ptr: u64) -> *const c_char;

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

        let _ = lab02(2, 1);
        breakpoint_hook(); // 添加钩子函数辅助断点调试

        lab03();
        breakpoint_hook(); // 添加钩子函数辅助断点调试

        // func_a, func_b 和 func_c 的函数逻辑应不同，避免编译器将 func_b 和 func_c 优化为为 func_a 的别名。
        let name_ptr = lab04(func_a as *const () as u64);
        let name = CStr::from_ptr(name_ptr);
        pl011::writeln(name.to_bytes());

        let name_ptr = lab04(func_b as *const () as u64);
        let name = CStr::from_ptr(name_ptr);
        pl011::writeln(name.to_bytes());

        let name_ptr = lab04(func_c as *const () as u64);
        let name = CStr::from_ptr(name_ptr);
        pl011::writeln(name.to_bytes());

        breakpoint_hook(); // 添加钩子函数辅助断点调试
    }
}

#[no_mangle]
pub extern "C" fn max3(a: u64, b: u64) -> u64 {
    if a > b {
        a
    } else {
        b
    }
}

#[no_mangle]
pub extern "C" fn func_a() {
    pl011::writeln(b"func_a's body");
}

#[no_mangle]
pub extern "C" fn func_b() {
    pl011::writeln(b"func_b's body");
}

#[no_mangle]
pub extern "C" fn func_c() {
    pl011::writeln(b"func_c's body");
}
