#!/bin/bash

rustup component add llvm-tools-preview

cargo install grcov rustfilt

brew install jq

RUSTFLAGS="-C instrument-coverage" cargo test --no-run --message-format=json | jq -r "select(.profile.test == true) | .filenames[]" > .test-bin-name

`cat .test-bin-name`

grcov . --binary-path ./target/debug -s . -t html --branch --ignore-not-existing -o ./target/debug/coverage/

open target/debug/coverage/index.html
