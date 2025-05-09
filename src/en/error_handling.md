**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>

# Error Handling {menu:topics;menu-caption:Intro}


Error handling is how a program deals with problems that happen while it’s running: like missing files, bad user input, or a network being down. Imagine you’re using an app and try to open a file that doesn’t exist. Without error handling, the app might just crash. But with good error handling, we can identify the issue, inform the user and take proper actions.

In **V**, error handling is explicit and visible. bla bla...

# Error Type {menu:topics}

The **Error** type represents an error and provides basic information about the error. In **V** the **Error** type is a generic name given to any [struct](scructs.md) that complies with the `IError` interface. The `IError` interface requires only two methods to be implemented `code()` and `msg()`.

{class:v-play}
```v
fn main(){
	my_error := error('The username selected does not meet the required standards. See https://myapp.com/help/usernames')
	println(my_error)
}
```

Here we use the function `error(message)` to create a generic error (`MessageError` Type). We assign this error type to the variable `my_error` and then we display the error.

> We also have the function `error_with_code(message, code)` that creates an error type a with a message and an integer error code.


## Error Type Methods

The function `error.code()` returns an `int` with the error code. The default error code is 0;

The function `error.msg()` returns a `string` with the error message.


IError Interface



`match err {}` or using `err is SomeErrType` and using `None__`

use err.code()


error(msg)
error_with_code(msg, code)

Custom error types



# Result Type {menu:topics}

In a [**result type**](https://en.wikipedia.org/wiki/Result_type) we can have a function that returns a value on success, or a **error type** on failure.

> A Result Type is a functional programming construct where it acts as a container that holds either: a successful value, or an error.

To turn the return data type of a function into a *result type* we just prefix the type with `!`. For example if my return type is `string`, then `!string` is the equivalent result type.

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
explain here...

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
# Custom error type {menu:topics}

We can create our own custom error type by using [structure composition](structs.md#composingstructures). Here we have two main choices. If we want to use the built-in `msg()` and `code()` functions we use the `MessageError` for composition else we use `Error` which would give us an empty error for us to implement them.

```v
struct PathError {
	MessageError //<-- our base struct
	path string //<-- add some extra information
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

```v
struct PathError {
	Error
	path string
}
fn (err PathError) msg() string {
	return 'Failed to open path: ${err.path}'
}
fn (err PathError) code() int {
	return 25
}

fn read_file(path string) !string {
	if path == '' {
		return PathError{ path: path }
	}
	return 'File content'
}
```

One bonus of using custom error is the ability to use the `is` operator to check the type of error:

```v
if err is PathError {
	println('We got a path error!')
}else if err is ReadError {
	println('We got an IO error!')
}

```

Notice that in **V** nothing will stop you from rolling your on error struct like for example:

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

# Optional Type {menu:topics}






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
# Discussion

