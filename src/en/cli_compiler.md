
# Options

| Option | Description |
| --- | --- |
| `-run` | compiles and runs the code. After a successful run, V will delete the generated executable. |
| `-crun` | Compile and run a V program without deleting the
   executable. |
| `-freestanding` | Compiles without **libc**. |
| `-showcc` | Prints the C command that is used to build the program. |
| `-show-c-output` | Prints the output, that your C compiler produced while compiling your program. |
| `-keepc` | Do not delete the generated C source code file after a successful compilation. It also keeps the binaries. |
| `-cg` | produces a less optimized executable with more debug information in it. The executable will use C source line numbers in this case. It is frequently used in combination with `-keepc`, so that you can inspect the generated C program in case of panic, or so that your debugger (gdb, lldb etc.) can show you the generated C source code. |
| `-g` | produces a less optimized executable with more debug information in it. V will enforce line numbers from the .v files in the stacktraces, that the executable will produce on panic. It is usually better to pass `-g`, unless you are writing low level code, in which case use the option `-cg`. |
| `-o <file.c>` | Produce the transpiled C file. For example `-o file.c` will compile the V sources and produce the C equivalent code in the file "file.c". |
| `-pringfn <fn_name>` | Produce the C soure for a given function only. Use in conjuction with `-c`. |



