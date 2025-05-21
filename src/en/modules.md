
**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>

# Modules  {menu:topics}

Writing modularized code is important to manage code complexity and maximize code reusability and readability. We separate functionality into distinct pieces of code, usually by purpose or context. In V, **modules** are a way to logically organize and structure code, grouping related functions, types, constants, and other definitions under a single namespace.

The natural approach to managing source code is to split it into multiple files. In V, a module builds on this approach by introducing the concept of logical collections of code. Think of a module as a named collection of related code.

When a file is compiled, its code is assigned to a module, either the default module `main` or a module you explicitly specify. Every line of code executed in **V** belongs to a module.

Each **module** has its own code and acts like its own little world. If a module wants to use functionality defined in another module, we **import** that other module so its contents become visible inside our module.


# Define a module {menu:topics}

The directive `module mymodule` tells the compiler that the contents of a file belongs to the module identified by the name given, here, "mymodule" is the name of the module. Lets see an example of some helper code that we want to reuse.

```v
// File: utilities.v

module utilities

do_something(){
	
}
do_that(){
	
}
```

We add the keyword `module` to the top of our file. The keyword module is followed by the module's name. The module name follow the same rules as variable's [name](./variables.md). In this example we created the `utilities` module with two functions. All the code defined under the same module name is treated as a single logical unit even if it was defined in different files.

For examples lets pretend I have a lot of utility functions for manipulating strings. I can create another separate file named "string_utilities.v" to further organize our code. 

```v
// File: string_utilities.v

module utilities

pub do_this(){
	
}
```
Since both files have the same module name, the V compiler automatically combines all the code from these two file and makes it available under the module name "utilities". 

These three functions are only visible (their scope) in code that belongs to the "utilities" module. In "utilities.v" we can use code declared in "string_utilities.v" and vice versa. 

```v
// File: utilities.v

module utilities

pub do_something(){
	do_this() //<-- defined in string_utilities.v
}

do_that(){
	
}
```

The keyword `module` defines our logical scope named "Utilities". Files that have a different module name will NOT see the code defined inside the utilities module. To use a module in other places we have to explicitly tell V that we want to use that code with the keyword `import`.

## Public visibility {menu:topics}

One important consideration before using our module elsewhere is to think about the visibility (scope) of the functions and data types (such as structs) defined in the module. When writing your module’s code, ask yourself: what is intended to be used outside the module, and what exists solely to support the module’s internal functionality?

To the outside world everything in our module is private by default. In V, we need to make things public to be able to access them outside our module. We use the access modifier `pub` to mark things public.

In our examples notice that we have prefixed some of our functions in the module with the modifier `pub`. Every [function](./functions.md) made public with `pub` will be accessible outside the module while functions that do not, like `do_that()` can only be used inside our module. This is also required for [structures](./structures.md) and other types we define in our module.

```v

// A public constant
pub const min_value = 100

// A public struct
pub struct Point {
mut:
	x int
	y int
}

// A public function
pub do_something(){

}

// A private function
do_that(){
	
}
```

Visibility only applies to code outside our module. Inside our module both private and public members are visible.

In V the following first level items can be made public:

- `const` constant
- `enum` enumeration
- `fn` function/method
- `struct` structure
- `union`
- `interface` interface
- `type` type alias


# Using a module {menu:topics}

In a file we can use the code of a module using the keyword `import`. The import keyword is followed by the name of the module we want to add.

```v
import utilities

fn main(){
	utilities.do_something() //<<-- call code
}
```

To use public functions and types defined in a module we use the name of the module as a namespace to access them. In our example, we use `utilities. do_something()` to call the function `do_something()` of our module "utilities". 

# File organization and modules  {menu:topics}

We mentioned before that we instinctively start organizing our code into separate files and folders. Before doing so, it's important to understand how the V compiler finds and includes files in your project along with some important rules.

> Trick: In V, **we do not import files**, we import logical modules. The key is understanding how to tell V which files to include in the compilation process.

Let's start with a simple project. Suppose we create a folder named `src` (short for source code). Inside the `src` folder, we add a file named `main.v` for our application.

To run our code, we might execute the following command: `v run ./main.v`. This command tells V to compile and run only the `main.v` file. However, this is **not** the command we want to use for multi-file projects. The important detail here is that **all other files in your project will be ignored** by the compiler; only `main.v` is compiled. This command is fine for single-file programs but won’t work when your project has multiple files or directories. The builder will even show you the message "If the code of your project is in multiple files, try with `v .` instead of `v ./main.v`" suggesting that you are using the wrong command.

> When a module is not found we will see the error "main.v:2:1: builder error: cannot import module "Utilities" (not found)".

Instead, use the command `v run ./`, which compiles all `.v` files in your project folder, including those in subdirectories. This is the command we will use for multi-file projects.

Continuing with our example, suppose we add our "Utilities" module. We have several ways to organize the files. One simple option is to place `utilities.v` and `string_utilities.v` alongside `main.v`. Our `src` folder structure would look like this:

```sh
src/
  /src/main.v
  /src/utilities.v
  /src/string_utilities.v
```

We run the project with the command `v run ./`, and the builder will compile utilities.v and string_utilities.v along with main.v. This ensures that the `Utilities` module is found and all its public functions and types are available to the rest of our code.

As our project grows in complexity, the "src" folder becomes too cluttered. To fix this, we can organize modules into subdirectories. For example, we can create a folder named "utilities" to contain our module files. The project structure would then look like this:

```sh
src/
  /src/main.v
  /src/utilities
    /src/utilities/utilities.v
    /src/utilities/string_utilities.v
```

Our project folder looks pristine! But wait there is an important rule to make this work!

In V, modules organized in subdirectories must have the same name as the module. When you import a module like `import utilities` for the first time, the builder will first look for the module in the same directory as the source file. If it's not found there, it will then search for a subdirectory named "utilities".

> Careful: files in a modules folder need to declare the same module name with the `module` keyword at the top of the file.

For clarity we can also create a folder named "modules" in our project and the V builder will search for modules inside this folder. Using a modules folder our project folder would look like this:

```sh
src/
  /src/main.v
  /src/modules/
    /src/modules/utilities
	  /src/modules/utilities/utilities.v
	  /src/modules/utilities/string_utilities.v
```

## Sub-modules {menu:topics;menu-id:submodules}

When a module grows in complexity we will want to break the module into sub-modules each doing their very specialized part. We use subdirectories inside our module's folder to organize our sub-modules. 

The rules are the same as we saw before. Lets see an example were we add a "validations" sub-module to our "utilities" module. The folder tree now looks like this:

```sh
src/
  /src/main.v
  /src/utilities
	/src/utilities/utilities.v
	/src/utilities/string_utilities.v
	/src/utilities/validations
	  /src/utilities/validations/validations.v
```

In our file `/src/utilities/validations.v` we declare our module name with the statement `module validations`. Up to this point everything that we have done is the same.

To **import** our "validations" module we will use a different syntax. Lets see how the import would look in our `main.v` file, For sake of brevity lets say we have a public function `check_username()` that we want to use from this "validations" module.

```v
// File main.v

import utilities.validations


fn main(){
	
	u := "joe" 
	if !validations.check_username(u) {
		println("Bad username...")
	}
	
}

```

Our import statement now uses a dot to indicate the module hierarchy that the builder will use to locate your module. This module hierarchy must match your folder structure.

Like always we use the name of the module to access its public members. In our example, we used `validations.check_username(u)`.


## Default module {menu:topics;menu-id:modmain}

Not everything needs to be segregated into its own module. V always creates a default module named `main`. In our example, the file `/src/main.v` automatically belongs to the `main` module. If we add other files at the same level without an explicit `module` declaration, they will also be part of the `main` module. We can use this to break the application logic into multiple files without creating new modules.

For example, code in the file `/src/validations.v` will be available in `/src/main.v`, and vice versa.


# Aliases and name collisions {menu:topics;menu-id:aliases}

The name of a module is unique else the compiler will not know which module a name references. When a module has the same name as another module we can use **aliases** to assign a unique name to one of the modules.

For example we have two modules named "validations" that we need to use in a project. One is found at "/src/utilities/validations" and the other is at "/src/google/validations". If we try to import both doing something like this:

```v
import utilities.validations
import google.validations
```

The builder will give us an error. To fix the error we change our import statement to set an alias for one of the imports with the `as` keyword. Lets change google's "validations" to be named "g_validations".

```v
import utilities.validations
import google.validations as g_validations

fn main(){
	u := "joe" 
	if !validations.check_username(u) {
		println("Bad username...")
	}
	
	if !g_validations.account_exists(u) {
		println("Bad username...")
	}
	
```

Notice that now we use the name `g_validations` in our code instead of 'validations'.

We can also use aliases to shorten the name of a module. For example a module with a name "files" could be imported as "io".

# Module initialization & cleanup  {menu:topics}

We can add two special function to a module a `init()` and `cleanup()` function. When present the `init()` function is automatically called when the module is imported for the first time. In a similar fashion the `cleanup()` is automatically called when the program exits.

```v
module mymodule

fn init() {
	println('from init')
}

fn cleanup() {
	println('from cleanup')
}

pub fn my_fn() {
	println('from my_fn')
}
```

> These function can only be defined once in a module scope.


# Packages, sharing modules between projects and with others {menu:topics;menu-id:vmod;menu-caption:Sharing modules}

Sharing modules between projects require us to place our modules in a folder where other projects can find them. 

## The V modules folder

V creates the folder `~/.vmodules` by default for storing modules that you want to share between projects. This folder is also used for third-party modules we instal.
 
> The location of the modules folder can be controlled by setting the env variable named `VMODULES`. By default, modules are installed to `~/.vmodules` (`C:\Users\<user id>\.vmodules` on Windows). On MacOS/Linux use `export VMODULES="$HOME/.vmodules"`.

## Specify a search path

V allows us to specify a list of folders where it should search for modules passing the command line argument `-path`. The `path` option must be given before we specify `run` or compile.

The path option is a string argument with paths that V searches for a module. The order in which the paths are listed is the order in which the paths will be searched. The paths are delimited with a pipe `|`. Paths can be relative or absolute. In addition to traditional paths we can include the following special strings:

**@vmodules** - Is a shorthand for the path of the currently configured "vmodules" folder.

**@vlib** - Is the path of V's standard library (vlib).

Lets see some examples:

```sh
v --path "@vlib|@vmodules|~/Projects/my_v_modules"
```

In this example we added the path to the folder "my_v_modules" where we keep our personal modules we use. 

```sh
v --path "~/Projects/my_v_modules|@vlib|@vmodules"
```

In this example we change the order to get V to use the modules in our "my_v_modules" folder, before it checks for V own modules or modules installed in the modules folder.


# Deprecation annotations {menu:topics}

A module can be tagged as **deprecated** using the deprecation annotations.

```v
@[deprecated: 'use xxx.yyy']
@[deprecated_after: '2999-01-01']
module my_old_module

pub fn do_something() {
	println("@do something...")
}
```

//ToDo research behavior...

# Packages {menu:topics}

In V, **packages** are simply modules that we distribute for other people to use, mainly using V' builtin package manager [VPM](https://vpm.vlang.io).

*TODO Will elaborate in the future...*
 

# Research 

If the module is invalidated, it can be marked by using deprecated or deprecated_after annotations, and the module user will be prompted to invalidate the information when compiling.

```v
@[deprecated: 'use xxx.yyy']
@[deprecated_after: '2999-01-01']
module ttt

pub fn f() int {
	return 1142
}
```