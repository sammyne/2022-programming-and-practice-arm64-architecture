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

global_asm!(include_str!("breakpoint_hook.s"));

extern "C" {
    fn lab01();
    fn lab02();
    fn lab03();
    fn lab04();

    //fn compare_and_return(a:u64,b:u64)->u64;

    fn breakpoint_hook();
}

#[panic_handler]
fn on_panic(_info: &PanicInfo) -> ! {
    loop {}
}

#[no_mangle]
pub extern "C" fn not_main() {
    let out_str = b"Welcome to mini-os :)\n";
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
    }
}
