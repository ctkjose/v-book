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
