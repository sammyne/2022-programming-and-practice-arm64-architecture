#![no_std]
#![no_main]

use core::arch::global_asm;
use core::panic::PanicInfo;

use mini_os::pl011;

global_asm!(include_str!("asm/start.s"));

global_asm!(include_str!("asm/hello_world.s"));

global_asm!(include_str!("asm/breakpoint_hook.s"));

extern "C" {
    fn hello_world();

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
        hello_world();
        breakpoint_hook(); // 添加钩子函数辅助断点调试
    }
}
