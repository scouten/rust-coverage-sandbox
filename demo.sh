#!/bin/bash

rustup component add llvm-tools-preview

cargo install rustfilt

RUSTFLAGS="-C instrument-coverage" cargo test

$(rustc --print sysroot)/lib/rustlib/aarch64-apple-darwin/bin/llvm-profdata merge -sparse default.profraw -o default.profdata

# DEMO FAILS HERE:
# error: target/debug/deps/librust_coverage_sandbox.rlib: Failed to load coverage: No coverage data found

# What should we do instead to test coverage in a library
# when executed via cargo test?

$(rustc --print sysroot)/lib/rustlib/aarch64-apple-darwin/bin/llvm-cov show -Xdemangler=rustfilt target/debug/deps/librust_coverage_sandbox.rlib \
    -instr-profile=default.profdata \
    -show-line-counts-or-regions \
    -show-instantiations
