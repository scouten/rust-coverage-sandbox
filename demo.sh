#!/bin/bash

rustup component add llvm-tools-preview

cargo install rustfilt

RUSTFLAGS="-C instrument-coverage" cargo run

$(rustc --print sysroot)/lib/rustlib/aarch64-apple-darwin/bin/llvm-profdata merge -sparse default.profraw -o default.profdata

$(rustc --print sysroot)/lib/rustlib/aarch64-apple-darwin/bin/llvm-cov show -Xdemangler=rustfilt target/debug/rust-coverage-sandbox \
    -instr-profile=default.profdata \
    -show-line-counts-or-regions \
    -show-instantiations
