**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>

# Error Handling {menu:topics;menu-caption:Intro}


Error handling is how a program deals with problems that happen while it’s running: like missing files, bad user input, or a network being down. Imagine you’re using an app and try to open a file that doesn’t exist. Without error handling, the app might just crash. But with good error handling, we can identify the issue, inform the user and take proper actions.



# Error Type {menu:topics}

The **Error** type represents an error and provides basic information about the error. In **V** the **Error** type is a generic name given to any [struct](scructs.md) that complies with the `IError` interface. Every error type must implement two methods `code()` and `msg()`.

In **V**, we have two functions to create quick generic errors, `error(message)` and  `error_with_code(message, code)`.

The function `error(message)` takes an error message and returns a generic error (`MessageError` Type). While the function `error_with_code(message, code)` adds a second argument an integer with an error code associated with this error.

{class:v-play}
```v
fn main(){
	my_error := error('The username selected does not meet the required standards.')
	println(my_error)
}
```

In our example we used `error(message)` to create our error and assigned this error to the variable `my_error`, finally we display the error.

Unless you need specialized handling of errors or information beyond the message and code these functions will be more than enough to write robust error handling in **V**. By no means you are limited to these you can always roll your own [custom error](#ierror_interface).


# Handling errors with a result type {menu:topics;menu-caption:Result Type}

Using a [**result type**](https://en.wikipedia.org/wiki/Result_type) we can have a function that returns a value on success, or a **error type** on failure.

> A Result Type is a functional programming construct where it acts as a wrapper that holds either: a successful value, or an error.

In **V**, the return type of a function is easily  converted to a *result type* by just prefixing the type with `!`. For example if my return type is `string`, then `!string` is the equivalent result type.

{class:v-play}
```v

fn read_file(path string) !string {
	if path == '' {
		return error('File path is empty')
	}
	return 'File content'
}

fn main(){
	path := ''
	
	data := read_file(path) or {
		println('Unable to read file')
		exit(1)
	}
	println(data)
}
```

In this example `read_file()` may return a `string` or an error (`MessageError`). In **V**, the error handling is explicit and we the programmer are required to handle the error else our program will not compile. There are a couple of ways to do this.

## OR Block {menu:topics}

In our example When we call the function `read_file()` we use an `or { ... }` block to handle the error. Like other control structures the `or { ... }` allows to put code inside the curly braces that will be executed when the function execution returns an error. 

You can think of the **or** as sort of short hand if, the right side of the **or** is executed when the left side returns an error. 

In this example if our program can handle an empty `data` we can use a simpler `or { ... }` block where we just return an initial value that will be assigned to `data`. Doing this we ensure that `data` will always have a valid `string` value and not an error.

```v
data := read_file(path) or { '' }
```

Inside the `or { ... }` block we also have access to the special variable `err` that holds the error returned. Using the `err` variable we could:

Propagate the error by returning the `err` to the calling function.

```v
data := read_file(path) or { 
	println("ERROR OCURRED:" + err.msg() )
	return err
}
```

Inspect the error code to decide how to handle the error.

```v
data := read_file(path) or { 
	if  err.code() == 20 {
		println('Doing something else...')
		//handle this error
	} else if err.code() == 21 {
		//handle this error
		println('Need to do special things here...')
	} else {
		println('Unable to read file')
		println(err.msg())
		exit(1)
	}
}
```

We can use `panic()` to abort our execution.

```v
data := read_file(path) or { 
	panic(err)
}
```

Lets see another example using some of these strategies:
 
{class:v-play}
```v
fn read_file(path string) !string {
	if path == '' {
		return error_with_code('File path is empty', 20)
	}
	return 'File content'
}

fn main(){
	path := '' //<- an invalid path!
	
	if data := read_file(path) {
		println('We got data')
		//do something here...
		println(data)
	} else {
		if  err.code() == 20 {
			println('Doing something else...')
			//handle this error
		} else if err.code() == 21 {
			//handle this error
			println('Need to do special things here...')
		} else {
			println('Unable to read file')
			println(err.msg())
			exit(1)
		}
	}
	
}
```


# Optional Type {menu:topics}

Not all error are critical. In some instances, we can only return a value if certain conditions are met; otherwise, we cannot return the expected value type, but the execution of the program is not affected.

An [**optional type**](optional_types.md) is a wrapper to a valid value or an unassigned value (`none`) that lend itself as to handle many error conditions without generating errors.

In a function declaration we can specify an [**optional type**](optional_types.md) as our return type. This allows us to either return the expected value or the special value `none` to indicate that no value was returned. To create an optional type we just prefix the return type with a `?`.

{class:v-play}
```v
// tests...

fn do_optional(id int) ?string {
	if id == 1 {
		return "Grace"
	}
	return none
}
// return string or an error
fn do_error(id int) !string {
	if (id == 1) {
		return "Joe"
	}
	
	return error_with_code("invalid id", 2)
}

// return string or an error
fn do_error_op(id int) ! {
	if (id == 1) {
		err := error_with_code("The id was invalid", 2)
		return err
	}
}
fn main(){
	
	mut name := ?string(none)
	name = "joe"
	//name = none
	//r := ?name or {"empty"}
	println("Test Optional")
	println("  Type is: " + typeof(name).name)
	println("  FAILS if name != none { name } else { \"empty\" } = " + ( if name != none { name } else { "empty" } )  )
	println("  OK ?name or {\"empty\"} = " + typeof(name).name + ", " + ?name or {"empty"} )
	r := if name != none { name } else { "empty" }
	println("  r is: " + r)
	
	mut out1 := do_optional(1)
	if out1 != none {
		println("1. The data type is: " + typeof(out1).name + ", " + out1 )
	}else{
		println("1. The data type is: " + typeof(out1).name )
	}
	
	mut out2 := do_error(2) or { if err.code()==2 {"default"} else { "joe" } }
	println("2. The data type is: " + typeof(out2).name + ", " + out2)
	
	do_error_op(2) or { panic(err) }
	println("3. Was executed.")
	
	do_error_op(1) or { 
		out1 = "Joe"
		println(err.code()) 
	}
	
}
```

## IError Interface {menu:topics}

A custom error type is just a struct that implements the `IError` interface. This interface is extremely simple, it only requires these two methods:

- `error.code()` returns an `int` with the error code. The default error code is 0;

- `error.msg()` returns a `string` with the error message.

Ideally you want to implement a "to string" method to generate an informative message to users.

Here is an example of a Custom error type implementing the full interface:

```v
struct MyError {
pub:
	msg  string
	code int
}

// str returns the message and code of the MyError
pub fn (err MyError) str() string {
	return err.msg
}

// msg returns the message of the MyError
pub fn (err MyError) msg() string {
	return err.msg
}

// code returns the code of MyError
pub fn (err MyError) code() int {
	return err.code
}
```

An easier way to build a custom error type is to [structure composition](structs.md#composingstructures) with the built-in error types `Error` and `MessageError`.

The built-in struct `MessageError` makes it easier since it provides a msg and code property that simplifies the error creation. The built-in struct `Error` is a blank boiler plate and you will have to roll your own `msg()` and `code()` functions.

```v
struct PathError {
	MessageError //<-- our base struct
	path string //<-- add some extra information
}

struct ReadError {
	Error
	path string
}
fn (err ReadError) msg() string {
	return 'Failed to open path: ${err.path}'
}
fn (err ReadError) code() int {
	return 25
}

fn read_file(path string) !string {
	if path == '' {
		return PathError{
			msg:  'Path is blank'
			code: 25
			path: path
		}
	}
	return 'File content'
}
```
Notice that we defined two error types `PathError` using `MessageError` and `ReadError` using `Error`.

One bonus of using custom errors is the ability to use the `is` operator to check the type of error:

```v
if err is PathError {
	println('We got a path error!')
}else if err is ReadError {
	println('We got an IO error!')
}

```


# Discussion

`match err {}` or using `err is SomeErrType` and using `None__`

use err.code()


error(msg)
error_with_code(msg, code)

