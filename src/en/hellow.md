**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>

# Playground  {menu:topics}

The simplest way to try **V** is to use V's interactive [Playground](https://play.vlang.io).

We will use the [Playground](https://play.vlang.io) throughout this book to practice the concepts in the book.  Code snippets with the play icon will let you try them yourself in the Playground.



# Hello World!  {menu:topics}
Lets get a feel for writing programs in V with a simple [hello world](https://en.wikipedia.org/wiki/%22Hello%2C_World!%22_program) program. 

{class:v-play}
```v
fn main() {
	println('Hello, World!')
}
```

In **V**, [functions](functions.md) are declared with the `fn` keyword, followed by the name of the function (in this case `main`), the parameters to the function, if any (in this case there aren't any) inside `()`, then an opening and closing curly brace, `{ }`. The curly braces marks the start and end of a function body.

The body of the function is where we put the [statements](https://en.wikipedia.org/wiki/Statement_%28computer_science%29). In our function **main** we only have one statement a call to the function `println()`.

To execute a function we use its name followed by an opening and closing parenthesis. Inside the parenthesis we pass the corresponding value to each of the function's parameters (if any are required)

> We use the term **parameters** for the variables that are listed in the function definition, the *parameters list*. They act as placeholders for the values (arguments) that will be passed when the function is called. While **arguments** are the actual values or data that you pass to a function or method when you call it.
