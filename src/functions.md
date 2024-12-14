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

## Paramaters & arguments

We use the term **parameters** for the variables that are listed in the function definition, the *parameters list*. They act as placeholders for the values (arguments) that will be passed when the function is called. While **arguments** are the actual values or data that you pass to a function or method when you call it. These values are assigned to the corresponding parameters.

```v
fn greet(name string) string {
	return 'Hello, ' + name + '!'
}

fn main() {
	message := greet('Joe')
	println(message) // Outputs: Hello, Joe!
}
```

In the previous code snippet the function `greet` only has one parameter `name`. When we called our function the string value `'Joe'` is the argument that we passed to the parameter `name` of our `greet` function.

The parameter definition is just a variable name followed by its data type, for example `name string`. Think of it as a variable that you will use inside the function to reference the value (argument) that was passed to the function when it was called. In the example before notice that we use the variable `name` to build our greet message. We invoked the `greet` function with `greet('Joe')` therefore inside the function the variable `name` has the string value `'Joe'`. 

### Multiple parameters

We define additional parameters to the function by separating them with a coma. 
```v

fn greet(name string, greeting string) string {
	return '$greeting, $name!'
}

fn main() {
	message := greet('Joe', 'Good morning')
	println(message) // Outputs: Good morning, Joe!
}
```

The `greet` function now requires two arguments, the name of the person to greet and the actual greeting.

### Mutability of arguments

In V function **ALL** arguments are immutable by default, that is we can not modify them inside our function. To make an argument mutable we mark the function parameter as mutable by prefixing the variable with the **access modifier**  `mut`.


## Returning values

We use the keyword `return` to exit our function and 
```v
fn foo() (int, int) {
	return 2, 3
}

a, b := foo()
println(a) // 2
println(b) // 3
c, _ := foo() // ignore values using `_`
```


Functions are types

## Hoisting

In V all declarations are *hoisted*, which allows functions to be used in your code before their declaration.


