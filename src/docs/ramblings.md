
# Cross Compilation Research


https://dave.cheney.net/2016/01/18/cgo-is-not-go

https://actually.fyi/posts/zig-makes-rust-cross-compilation-just-work/

https://dev.to/kristoff/zig-makes-go-cross-compilation-just-work-29ho#

https://stackoverflow.blog/2023/10/02/no-surprises-on-any-system-q-and-a-with-loris-cro-of-zig/

https://flyx.org/nix-flakes-go/part3/

## Zig-CC

Zig often bundles necessary libraries (like libc) in source form, compiling them on-the-fly for the target, which simplifies the cross-compilation process significantly.

 It even contains the full musl libc source code and will dynamically compile it for requested target and link it statically to your program.


https://zig.news/kristoff/cross-compile-a-c-c-project-with-zig-3599
https://zig.news/kristoff/make-zig-your-c-c-build-system-28g5