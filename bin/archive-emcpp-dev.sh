#!/bin/sh

bin/build-emcpp-dev.sh &&
cp build/BeldexClient_WASM.js src/; 
cp build/BeldexClient_WASM.wasm src/;
cp build/BeldexClient_WASM.wasm.map src/;
