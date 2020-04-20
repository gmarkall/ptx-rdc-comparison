# PTX Comparison between code compiled with and without the `-rdc` flag

This repo contains a small example for examining the output of `nvcc` with and
without the `-rdc` ([Relocatable Device
Code](https://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc/index.html#options-for-steering-gpu-code-generation-relocatable-device-code))
flag.

The purpose of this example is to help aid discussions on:

- [Numba Issue #4574 - Default Compilation mode for CUDA Kernels](https://github.com/numba/numba/issues/4574)
- [Numba PR #5561 - CUDA: Add function for compiling to PTX](https://github.com/numba/numba/pull/5561)

Presently this test outputs the sequence of commands issued by `nvcc` (from the
`--dryrun` flag) and the generated PTX (using the `-ptx`) flag.


## Summary conclusions

The use of the flag guarantees the emission of code for all `__device__`
functions that are not forced to be inlined in the generated PTX. Code
generation for `__global__` functions is unaffected - for example, if a
`__device__` function was inlined into a `__global__` function without `-rdc`,
it will still be inlined when the PTX for the `__device__` function is emitted
due to the use of the `-rdc` flag.


## Building the example

To build the example, run:

```
make
```

The commands invoked by the `nvcc` driver for both cases are printed to standard
output. The difference in the PTX outputs, if any, is also printed to standard
output.

Outputs are stored to the `nordc` folder for the compilation without the `-rdc`
flag, and to the `rdc` folder for the compilation with the `-rdc` flag.
