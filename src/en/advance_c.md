{doc-type:doc;doc-version:1.0;doc-title:C Interoperability}
**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>
# C Interoperability {menu:topics;menu-id:intro}

V Lang is designed with C interoperability as a key feature, leveraging its C backend to facilitate seamless interaction between the two languages. This interoperability allows V code to call C functions and C code to call V functions, along with mechanisms for sharing data structures and managing compilation flags.


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