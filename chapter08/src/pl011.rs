use core::ptr;

const UART0: *mut u8 = 0x0900_0000 as *mut u8;

pub fn write(data: &[u8]) {
    for byte in data {
        unsafe {
            ptr::write_volatile(UART0, *byte);
        }
    }
}

pub fn writeln(data: &[u8]) {
    for byte in data {
        unsafe {
            ptr::write_volatile(UART0, *byte);
        }
    }
    unsafe {
        ptr::write_volatile(UART0, b'\n');
    }
}
