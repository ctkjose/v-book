{doc-type:doc;doc-version:1.0;doc-title:Functions}
**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>
# Functions  {menu:topics}

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

## Paramaters & arguments  {menu:topics}

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

### Multiple parameters  {menu:topics}

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

### Mutability of arguments  {menu:topics}

In a function **ALL** arguments are immutable by default, that is we can not modify them inside our function. We have to explicitly tell the compiler our intent to modify something.

> **IMPORTANT** V doesn't allow the modification of arguments with primitive types (e.g. strings, integers). Only more complex types such arrays, interfaces, maps, pointers, structs or their aliases can be modified.

We mark the function parameter as mutable by prefixing the variable with the **access modifier**  `mut`.

```v
fn multiply_by_2(mut data []int) {
    for i in 0 .. data.len {
        data[i] *= 2
    }
}
```
Here, we made our intent to modify the argument explicitly known to the compiler by prefixing the parameter `data` with the modifier `mut`.

We are not done yet. When calling our function, we must ensure not only that the arguments we are passing are mutable, but also that we explicitly indicate to the compiler that they can be modified. Let’s see an example of calling the `multiply_by_2()` function.

```v
fn main() {
    mut nums := [1, 2, 3]
    multiply_by_2(mut nums)
    println(nums) // Outputs "[2, 4, 6]"
}
```
Notice that when we call `multiply_by_2()` we added the modifier `mut` to the argument `nums` to match our `mut data`.

This is an agreement between the function definition declaring that it may modify a parameter and the caller confirming that it is passing a modifiable argument.

> When working with struct's methods (functions) there is also additional syntax involved when modifying the struct's fields. See [structs](./structs.md) to learn more.

## Returning values  {menu:topics}

A function that returns a value must specify the [type](variables.md#datatypes) of the value to be returned at the end of the function declaration. For instance the function declaration `fn add(a int, b int) int` will return an `int` type.

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

## Optional return type {menu:topics;menu-caption:Optional Type}

> See [Error Handling](./error_handling.md) for a more in-depth discussion.

In some instances we can only return a value if a given conditions are meet otherwise we can not return the expected value type.

In a function declaration we can specify an [**optional type**](./optionaltypes.md) as our return type. This allows us to either return the expected value or the special value `none` to indicate that no value was returned. To create an optional type we just prefix the return type with a `?`.

```v
fn find_user(id int) ?string {
    if id == 1 {
        return "Grace"
    }
    return none
}

fn main(){
    user := find_user(1)
    if user != none {
        println("User found:", user) // Output: User found: Grace
    } else {
        println("User not found")
    }
}
```

In this example the declaration of the `find_user` function makes its return type optional with `?string`, that is it returns a `string` or the special value `none`. 

## Returning Errors {menu:topics;menu-caption:Returning Errors}

> See [Error Handling](./error_handling.md) for a more in-depth discussion.

A function can return a valid type on success or an [error](./error_handling.md) type.

{class:v-play}
```v
fn do_something(s string) !string {
    if s == "foo" {
        return "foo"
    }
    return error("invalid string")
}

fn main(){
    a := do_something("foo") or { "default" } //<-- a will be "foo"
    b := do_something("bar") or { "default" } //<-- b will be "default"

    println(a)
    println(b)
}
```

We use the function `error(message)` to return an `IError` ([See section Error Handling](./error_handling.md)) type. In our calling function we use add  catch block with the `or` statement to put the code to be executed when an error is returned. Inside the catch block we have a special variable named `err` with the instance of the error.

In our example we are initializing our variable `a` with the results of calling `do_something()` the code ` or { "default" }` has the string that will be assigned when `do_something()` returns an error.

We are not limited to one value here. We could also inspect the `err` and assign a different value according to the error.

{class:v-play}
```v
fn do_something(s string) !string {
    if s == "foo" {
        return "foo"
    }else if s == "go" {
        return error_with_code("Why????", 2)
    }
    return error_with("invalid string")
}

fn main(){
    a := do_something("go") or { if err.code()==2 {"Really no shame!"} else { "" } }
    
    println(a)
}
```
In this example we use `error_with_code()` to add an error code to our error, by default the error code is `0`. In our assignment we check the error code and return the string `"Really no shame!"` if the string was `"go"` else we return an empty string.

 
In some instances we just need to raise an error on a function that does not return a value. To do so we just add the `!` without a return type.

{class:v-play}
```v
fn do_something(id int) ! {
    if (id == 1) {
        return error("The id was invalid")
    }
    
    // do stuff...
}

fn main(){
    mut ok := true
    
    // Abort on error...
    do_something(2) or { panic(err) } //<- calling panic will abort the execution
    
    // Handle the error...
    do_something(1) or { 
        println(err) //<-- prints the error...
        ok = false
    }
}
```

## Returning multiple values {menu:topics}

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


## Variable number of arguments  {menu:topics}

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

## Unpack array as function arguments  {menu:topics}

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

## Hoisting {menu:topics}

Unlike C and other languages in V all declarations are *hoisted*, which allows functions to be used in your code before their declaration.


