pub fn hello(answer: u16) {
    if answer == 42 {
        println!("Hello, world!");
    } else {
        println!("I have no idea what you're talking about.");
    }
}

#[cfg(test)]
mod tests {
    #[test]
    fn test_hello() {
        super::hello(42)
    }
}
