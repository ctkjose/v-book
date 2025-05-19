{doc-type:doc;doc-version:1.0;doc-title:C Interoperability}
**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>
# C Interoperability {menu:topics;menu-id:intro}

V Lang is designed with C interoperability as a key feature, leveraging its C backend to facilitate seamless interaction between the two languages. This interoperability allows V code to call C functions and C code to call V functions, along with mechanisms for sharing data structures and managing compilation flags.


https://docs.vlang.io/v-and-c.html#passing-c-compilation-flags

## Dereference operator (*)

In very particular scenarios, specially when working with critical code that must be optimized we can use the dereference operator `*` in a very similar fashion as we would in C code.

By default V will not allows to dereference pointers, so we have to explicitly mark our code as **unsafe**, which is basically you telling V that you are responsible for the security and correctens of your code.

```v
fn increment_score(s &int) {
    unsafe {
        //here we traet s like a pointer
        new_score := *s + 10 //dereference s and add 10
        *s = new_score
    }
}

fn main() {
    score := 20
    increment_score(&score)
    println('The score is $score') // Prints: "The score is 30"
}
```



# Static Compilation



https://github.com/vlang/v/issues/21760

Oliver Smith (kfsone) Comment
So I love the fact that V takes the "unsafe" concept a step further and firewalls shenanigans behind opt-in command lines switches.

# Pointers

V currently does not have references. It has pointers. Pointers have 0 as a valid value, no matter how you call it - NULL, nil etc.
V also has option types. The valid values of an option type, are none + the set of valid values for the wrapped type. 
=> In case of pointers, that in combination, means that ?&Type should allow p := ?&Type( unsafe {nil} )
Imho, anything else is arbitrary bullshit, that can not be justified, except perhaps as an aesthetic choice, in which case fine, but it is dumb, and will complicate things.

https://discord.com/channels/592103645835821068/592320321995014154/1371432151085744158


# Symbol Collisions

https://docs.vlang.io/v-and-c.html#working-around-c-issues


# V Standard Library


## LibC Compatibility

The **glibc** versions can vary from one distribution to another for example from Ubuntu 22.04 to Ubuntu 20.04. In general, glibc is not backward-compatible, meaning that binaries compiled with newer glibc versions will likely not run on older glibc versions. However, binaries compiled for older glibc versions are often forward-compatible and can run on systems with newer glibc versions.

> Tip: On Linux, use the command `ldd --version` to see which version of libc is installed.

When you compile an application it will be linked to the libc version of the system where it was compiled.

> Here is a [good article](https://www.tecmint.com/install-multiple-glibc-libraries-linux/) on installing multiple versions of glibc.

* Alpine Linux uses Musl.



## LibC or SysCalls

Using SysCalls instead of library calls (libc, glibc, musl-libc etc) poses some unique challenges for language design. Using Syscalls can provide the means to achieve a sort of language purity and independence yet we have to consider that building the language standard library only using Syscalls bounds the language implementation to the particularities of each kernel and architecture the language wishes to support. Even in Linux with a fairly standard ABI we will face a serious undertaking to keep up with the diversity and frequency of changes. This challenge becomes even greater when we add MacOS/iOS and Windows. Using Syscalls is an extremely low level coupling of the language and the OS. The guys a Go tried the syscall approach and [Zig](https://ziggit.dev/t/zig-libc-and-syscalls/5696) does implements their own standard library using syscalls albeit not for every target.

There are quite a few considerations that settles the decision to use libc.

- It would take a lot of effort and time to build a mature standard library with descent support across all of the main platform.
- V does not have the resources to create and maintain our own standard library using Syscalls.
- Current OS design intend for applications to use userspace libraries and the abstractions they provide in their API. Kernel ABIs are far more cryptic and unfriendly territory.
- Security models and sandboxing add more complexity to using syscalls.
- Libc portability is a huge advantage.
- Dynamic linking to the OS's libs produces smaller binaries and reduces internal dependencies.


# musl libc

https://wiki.musl-libc.org/getting-started.html
