# Functions

Functions are self-contained chunks of code that perform a specific task. You give a function a name that identifies what it does, and this name is used to “call” the function to perform its task when needed.

Functions are defined using the `fn` keyword followed by the function name, parameters (if any), and return type.

```v
fn function_name(parameters) return_type {
	// function body
}
```

For example: 

```v
fn greet(name string) string {
	return 'Hello, $name!'
}
```

Here
- `greet` is the function name.
- `name string` specifies a parameter named `name` of type `string`.
- `string` after the parameter list is the return type.

Functions are called by using their name followed by parentheses, passing any required arguments.

```v
fn greet(name string) string {
	return 'Hello, $name!'
}

fn main() {
	message := greet('Joe')
	println(message) // Outputs: Hello, Joe!
}
```

## Paramaters & Arguments

We use the term **parameters** for the variables that are listed in the function definition, the *parameters list*. They act as placeholders for the values (arguments) that will be passed when the function is called. While **arguments** are the actual values or data that you pass to a function or method when you call it. These values are assigned to the corresponding parameters.

```v
fn greet(name string) string {
	return 'Hello, $name!'
}

fn main() {
	message := greet('Joe')
	println(message) // Outputs: Hello, Joe!
}
```

In the previous code snippet the function `greet` only has one parameter `name`. When we called our function the string value `'Joe'` is the argument that we passed to the parameter `name` of our `greet` function.

In V function arguments are immutable by default, and mutable args have to be
marked on call.

Since there are also no globals, that means that the return values of the functions,
are a function of their arguments only, and their evaluation has no side effects
(unless the function uses I/O).

Function arguments are immutable by default, even when [references](#references) are passed.




Functions are types

### Hoisting

Functions can be used before their declaration:
`add` and `sub` are declared after `main`, but can still be called from `main`.
This is true for all declarations in V and eliminates the need for header files
or thinking about the order of files and declarations.

### Returning multiple values

```v
fn foo() (int, int) {
	return 2, 3
}

a, b := foo()
println(a) // 2
println(b) // 3
c, _ := foo() // ignore values using `_`
```
