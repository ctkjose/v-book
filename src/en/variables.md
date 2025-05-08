**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>

# Data Types and Variables {menu:topics;menu-caption:Intro}

In programming, data types are like categories that tell the computer what kind of information you’re working with and what operations we can do with this data. Just like you might sort items into boxes labeled “Books”, “Toys”, or “Clothes”, data types organize information into categories like numbers, text, or true/false values.

We use a variable to store data or point to data. A variable has a name ( like `user_name`, `success_message`, or `age` ) that we use to identify our variable and a value of a particular data type (for example the number `10` or the string `"Welcome"`).

When you create a variable in **V**, you’re storing a piece of data, and that data always has a type.

The V compiler use data types to know how to store the data in memory and it also makes code optimizations based on this knowledge. For us the programmers, the data type makes it harder to make mistakes in code and thus creates safer code.

Let’s look at the most common data types in **V**:

- `int` – Whole numbers, like 5, -3, or 100. [Learn More...](#numerictypes)
- `f32` / `f64` – Decimal numbers (floating-point), like 3.14 or -0.001
- `bool` – True or false values (like a yes/no switch)
- `string` – Text, like “Hello” or “My name is John”
- `array` – A list of values, such as [1, 2, 3]
- `map` – A collection of key-value pairs, like a dictionary

We will discuss these types in more details later.

# Variable Declaration {menu:topics;menu-caption:Declarations}

A variable must be declare before we use it. Let's see an example of declaring a variable:

{class:v-play}
```v
fn main() {
	name := "Alice"
	
	println(name);
}
```

Declaring a variable introduces a new name into the program. In the example above we defined the variable `name`. A variable must be initialized at the same time it's declared. Here we initialize `name` to the string "Alice". 

The syntax to declare a variable is:

```v
variableName := value
```

First we have a variable name followed by the `:=` operator. On the right side of the operator we provide the initial value of our variable. The variable's type is inferred from this value.

> A variable name must follow these rules:
> 1.	A variable name must begin with a lowercase alphabet character (a–z) or an underscore (_).
> 2.	After the first character, variable names can include lower case letters, digits (0–9), and underscores.
> 3.	Variable names are case-sensitive, so `name` and `Name` are considered different variables.
> 4.	You cannot use V language keywords like `if`, `for`, `mut`, `return`, etc., as variable names.
> For consistency across different code bases, all variable and function names must use the `snake_case` style, as opposed to type names, which must use `PascalCase`.





# Side Note on Naming Conventions

In V we use the **snake_case** naming convention when naming **variables**, **constants**, **functions**,  **struct's fields** and others.  In snake_case we only use lowercase letters to avoid case-sensitive issues and we separate words by underscores which mimic spaces to makes things easier to read. For example:

```v
// Variables
user_name := "Alice"
max_value := 100
```
# Visibility and mutability {menu:topics}

Visibility and mutability are two important concepts that we need to understand when using variables. Visibility refers to where is our variable accessible and mutability is the ability to change its contents. By default the V compiler will produce the simplest and safer code, that means that:

- We can only declare variables inside a [function](./functions.md) and they are only visible in the function they are created. There are no **global** variables in V.
- Variables in V are **immutable** by default, their value cannot be changed after initialization. In V we explicitly control when a variable is mutable.

## Mutability {menu:topics}

In V we need to explicitly tell when we want to change a value of a variable (mutate). We use the **access modifier** `mut` in front of a variable declaration to indicate that a variable is mutable.

{class:v-play}
```v
fn main() {
	mut name := "Alice"
	mut age := 30
	pi := 3.14159 //<------ immutable!
}
```

Here, `name` and `age` are mutable variables, their values can be changed later in the program. In the other hand `pi` is immutable since we do not what to change its value. 

> It’s a good practice to create immutable values in all cases where the variable doesn’t need to change. Immutable values make safer code, allows the compiler to better optimize our code and play nicely in concurrent tasks.

# Type Inference {menu:topics}

V is a statically typed language, which means the type of each variable is known at compile time.

When we initialize a variable we assign an initial value. V will infer the variable data type from the type of value assigned. 

The basic data types are:
- **int**: Integer type
  ```v
  x := 42
  ```

- **f64**: Floating-point numbers
  ```v
  pi := 3.14 // inferred as f64
  ```

- **bool**: Boolean type
  ```v
  is_valid := true
  is_enabled := false
  ```

- **string**: String type
  ```v
  message := 'Hello, V!'
  ```

We can use the function typeof to print the data type of a value. 

{class:v-play}
```v
fn main(){
	pi := 3.14
	
	println("The data type of pi is: " + typeof(pi).name )
}
```

## Explicit types {menu:topics}

In some cases you want to specify a type that is different to the one V automatically infers from the context. For example numbers can have different precision and size. We have unsigned/signed integers, 8 bits, 32 bits or 64 bits integers. It's important to have the correct type for code compatibility and to optimize your code for performance and memory use.

```v
score := 95 //<--  inferred as int (32 bytes signed integer)
```

We can explicitly tell the compiler the type we want. For instance the following example inferred a 32 bytes floating point but we need a floating point number with more precision.

```v
fn main() {
	mut temperature := 36.6 //<-- inferred a 32 bits floating point
	println(temperature); //<-- prints the value
	println("The data type of temperature is: " + typeof(temperature).name )
}
```

We modify our `temperature` declaration to specify the type. Our code will now look like this:

{class:v-play}
```v
fn main() {
	mut temperature := f64(36.60) //<-- explicit 64 bits floating point
	println(temperature);
}
```

# Variable scope {menu:topics}

The scope of a variable determines where in your code that variable can be accessed. In **V**, variables are scoped to the block of code where they are declared (e.g., within a function or a for loop).


{class:v-play}
```v
fn my_function() {
	x := 10
	println(x) // x is accessible here
}

fn main() {
	my_function() //<-- call function
	
	println(x) //<-- compile error, x is out of scope
}

```

You will learn more about scope as we progress through the book.

# Numeric Types {menu:topics}

Numbers are divided into two groups **whole numbers** (such as 125) and numbers with **decimals** (such as 236.25). Whole numbers are called **integers** and numbers with fractional parts are **floats** (short for floating point numbers).

> Integers use the basic type `int` and floats use `f32`.

In addition number can always have a positive value or either be positive or negative. We refer to this as is the number **unsigned** or **signed**. Integers that can only be positive are **unsigned integers** and values that can be either are **signed integers**. Floating point numbers are always signed.

> A variable of type `int` is a signed 32 bit integer.

We categorize numbers further by how much memory they use, the more memory the larger the number that can be represented by a number. In **V** we have 8 bits, 16 bits, 32 bits and 64 bits numbers.

> The size of the number is important for two reasons: it limits what is the smallest and largest value we can store in a variable and it optimizes the memory usage of our program.

| Type | Min Value | Max Value |
| --- | --- | --- |
| `i8` | -128 | 127 |
| `i16` | -32768 | 32767 |
| `i32` | -2147483648 | 2147483647 |
| `i64` | -9223372036854775808 | 9223372036854775808 |
| `u8` | 0 | 255 |
| `u16` | 0 | 65535 |
| `u32` | 0 | 4294967295 |
| `u64` | 0 | 18446744073709551615 |

## Alternate notation for numbers

A number can also be written in hexadecimal, octal and binary.


Literal numbers in hexadecimal notation start with `0x`. 

```v
carriage_return := 0x0D //<-- 13
line_feed := 0x0A //<-- 10
```

Literal numbers in octal notation start with `0o`. 

```v
carriage_return := 0o15  //<-- 13
line_feed := 0o12 //<-- 10
```

Literal numbers in binary start with `0b`. 

```v
carriage_return := 0b1101  //<-- 13
line_feed := 0o1010 //<-- 10
```
