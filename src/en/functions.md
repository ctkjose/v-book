# Functions

Functions are self-contained chunks of code that perform a specific task. You give a function a name that identifies what it does, and this name is used to “call” the function to perform its task when needed.

Functions are defined using the `fn` keyword followed by the function name, parameters, and return type. The parameters and return type are optional.

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

In the previous code snippet the function `greet` only has one parameter `name`. When we invoke the function the string value `'Joe'` is the argument that we passed to the parameter `name` of our `greet` function.

The parameter definition is just a variable name followed by its data type, for example `name string`. Think of it as a variable that you will use inside the function to reference the value (argument) that the function received. In the example before notice that we use the variable `name` to build our greet message. We invoked the `greet` function with `greet('Joe')` therefore inside the function the variable `name` has the string value `'Joe'`. 

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

The `greet` function now requires two arguments, the name of the person to greet and the actual greeting. The value of the arguments, in this case the strings `'Joe'` and `'Good morning'` are passed to the respective parameters `name` and `greeting` following the order in which they were declared.

### Mutability of arguments

In a function **ALL** arguments are immutable by default, that is we can not modify them inside our function. 

> **IMPORTANT** V doesn't allow the modification of arguments with primitive types (e.g. strings, integers). Only more complex types such arrays, interfaces, maps, pointers, structs or their aliases can be modified.

To make an argument mutable we mark the function parameter as mutable by prefixing the variable with the **access modifier**  `mut`.

```v
fn multiply_by_2(mut arr []int) {
    for i in 0 .. arr.len {
        arr[i] *= 2
    }
}
fn main() {
    mut nums := [1, 2, 3]
    multiply_by_2(mut nums)
    println(nums) // Outputs "[2, 4, 6]"
}
```

## Returning values

We use the keyword `return` to exit our function and  return a value to the code that invoked our function.

```v
fn add(a int, b int) int {
    return a + b
}

fn main() {
    // Call the function and assign the return value to the local variable result	
    result := add(5, 3) 
    println(result)     // Output: 8
}
```
Functions can return multiple values. To do so we first modify our function declaration to now list the different data types that will be returned. The `return` statement can now return multiple values by listing the values to be returned in order separated by a coma `,`.

```v
fn calculate(a int, b int) (int, int) {
    sum := a + b
    product := a * b
    return sum, product
}

fn main() {
    sum, product := calculate(5, 3) // Capture both return values
    println('Sum: $sum')            // Output: Sum: 8
    println('Product: $product')    // Output: Product: 15
}
```

> **Go Users**: Notice that the type of a parameter is always specified. While `func my_func(a, b int) int` is a valid Go function declaration in V you must use `fn my_func(a int, b int) int`.

When we invoke a function we can ignore the returned value by using the special underscore variable (`_`). The `_` acts as a generic trash can. 

```v
fn doSomething(a int, b int) int {
    return a + b
}
fn foo() (int, int) {
    return 2, 3
}

fn main() {
    // Call the function and ignore the returned value
    _ := add(5, 3)

    //We can also ignore a particular value when the function returns multiple values
    a, b := foo() //regular call, use all the values returned
    println(a) // Outputs 2
    println(b) // Outputs 3
    c, _ := foo() // ignore the second value using `_`
    println(c) // Outputs 2
}
```
## Variable number of arguments

V supports functions that receive an arbitrary, variable amounts of arguments, denoted with the `...` prefix. These functions are called **variadic functions**.
Below, `a ...int` refers to an arbitrary amount of parameters all which are of type `int` that will be collected into an array named `a`.

```v
fn sum(a ...int) int {
    mut total := 0
    for x in a {
        total += x
    }
    return total
}

fn main() {
    println(sum()) // Outputs 0
    println(sum(1)) // Outputs 1
    println(sum(2, 3)) // Outputs 5

    // using array decomposition, to convert each array element
    // into an argument to the function
    a := [2, 3, 4]
    println(sum(...a)) // <-- using prefix ... here. output: 9

    b := [5, 6, 7]
    println(sum(...b)) // output: 18
}
```

## Unpack array as function arguments

We use the **spread** operator `...` to pass array elements as individual arguments to a function. The array decomposition syntax is `...myarray`. Here each element of the array `myarray` becomes an argument to the function. For example a call like `sum(...[1, 2, 3])` is equivalent to `sum(1, 2, 3)`.


This is very useful when combined with variadic functions. Lets see an example:

```v

fn sum(a ...int) int {
    mut total := 0
    for x in a {
        total += x
    }
    return total
}
fn main() {
    
    my_values := [2, 3, 4]
    println(sum(...my_values)) // <-- using prefix ... here. output: 9

}
```

Apple
:   Pomaceous fruit of plants of the genus Malus in 
    the family Rosaceae.
:   An American computer company.

Orange
:   The fruit of an evergreen tree of the genus Citrus.
   
## Hoisting

Unlike C and other languages in V all declarations are *hoisted*, which allows functions to be used in your code before their declaration.


