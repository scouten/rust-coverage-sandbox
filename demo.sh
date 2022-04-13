#!/bin/bash

rustup component add llvm-tools-preview

cargo install rustfilt

brew install jq

RUSTFLAGS="-C instrument-coverage" cargo test --no-run --message-format=json | jq -r "select(.profile.test == true) | .filenames[]" > .test-bin-name

`cat .test-bin-name`

$(rustc --print sysroot)/lib/rustlib/aarch64-apple-darwin/bin/llvm-profdata merge -sparse default.profraw -o default.profdata

$(rustc --print sysroot)/lib/rustlib/aarch64-apple-darwin/bin/llvm-cov show  \
    -Xdemangler=rustfilt \
    `cat .test-bin-name` \
    -instr-profile=default.profdata \
    -show-line-counts-or-regions \
    -show-instantiations
