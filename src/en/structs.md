**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>
# Structures  {menu:topics}

Structures (**structs**) allow users to define a complex data type by grouping different variables together under a single name. Structures are particularly useful for representing complex data, objects and entities. The values that make up the structure are known as members or fields.

We define a structure with the keyword `struct` followed by the structure's name.  The name of our structure becomes a new named type that we can use in the program. 

> The name of a structure uses the [PascalCase](https://en.wikipedia.org/wiki/Naming_convention_programming) naming convention, that is the first letter of each word is capitalized and the rest is lower case.

```v
struct User {
    email string
    activated bool
}
```

In the above example we defined a structure to represent a "user".  In our user struct we have a field for the user's email and the boolean field "activated" to indicate whether the user account is active or not. You can think of fields as variables for our struct.

The fields in the structures are primitive types like strings, numbers, or other named types supported by V, like structures, enumerations, etc. We place our fields within a pair of braces `{ ... }` that mark the body of our structure.

A few details that we need to know when declaring member fields in a structure are:

* Unlike a variable a field name is always followed by the *type* of the field. 
* Like with variables, V will initialize the field to its default value, for example a numeric field will have an initial value of 0.
* Assign another default value using the `=` operator followed by a valid expression.  The declare/initialize`:=` operator is not supported in struct's fields.

```v
struct User {
    email string
    date_created string
    activated bool = true
    need_password_reset bool
    quota_size int = 1000 //set an initia quota
}
```

# Using a structure {menu:topics}

When we define a structure we created a new **named type**. The name of the type is the name of the struct like for example `User` . We use our new type to create instances of our structure and we assign this instance to a variable. Lets see an example of how to create an instance:

```v
user := User{}
```

In the above example `User{}` creates a new intance of the structure `User` , you can think of it as a copy. The new structure instance was assigned to the variable `user`.  The fields of our structure have the default values of its type  that is strings are empty strings, numbers are 0, booleans are false, etc. The field for which we explicitly assigned a default value with the `=` operator will be initialized to that given value.

When we create an instance of the structure we can pass the values for each of the corresponding fields in the structure.
```v
user := User{'joe.doe@mail.com', '25/10/2024', true, false, 500}
println("User is ${user.email}")
```
There are two ways to do this. The first method shown in the example above is used to initialize all the values on the structure.  We pass a value for each of the corresponding fields in the order they appear in the structure and the values are delimited by a coma `,`.  

Since fields in a structure are initialized to their default values the second method allows us to only assign values to particular fields. Lets see an example:

```v
user := User{email: 'joe.doe@mail.com' , quota_size:500}

println("User is " + user.email)
```

Notice how in the above example we only pass two values when we create our new instance of `User`. To tell V which value corresponds to which field we add the name of the field followed by the colon `:`, for example `email: 'joe.doe@mail.com'`.

## Making a field required {menu:topics}
In some instances we want to make sure that a particular field always has a valid value when a new instance is created. For example a new instance of a `User` must always have the user's email. We can tell V to make a particular field required with the `[required]` attribute. Lets revisit our `User` structure and make the field `email` required:
```v
struct User {
    email string @[required]
    date_created string
    activated bool = true
    need_password_reset bool
    quota_size int = 1000
}
```

## Accessing fields {menu:topics}
We use the `.` to access a field value.  For example:
```
email := user.email
if !user.activated {
  println("User \"${user.email}\" is not active.")
}
```

# Visibility and mutability {menu:topics}
Visibility and mutability are two important concepts that we need to understand when using our structures. Visibility refeers to where is our structure accesible and mutability is what can be modified. By default the V compiler will produce the simplests and safer code, that means that:

First structures are only visible in the module they were created, our structure is **local** to the module. 

> Remember if a source file doesnt specify a module name with the `module` keyword that code will executed under the default **main** namespace.

Second once our structure instance is created the values can not be modified, the structure is **inmutable**.

In V we explicitly control when a structure's field is mutable, when the structure itself is mutable and when we expose our structure to other modules.

## Mutability {menu:topics}
In V we need to explicitly tell when we want to change a value (or mutate). We can recall that we make a variable mutable by prefixing the variable with the **access modifier**  `mut`.  This is also true for structure instances.          

> It’s good practice to create immutable values in all cases where the variable doesn’t need to change. Immutable values make safer code, allows the compiler to better optimize our code and play nicely in concurrent tasks.

We need to tell V that we intend to modify the fields of our new structure variable. First we are going to change our structure instantiation so that our variable `user` is now mutable:

```v
// mutable
mut user := User{email: 'joe.doe@mail.com' , quota_size:500}
```

The next step is to indicate which fields are mutable. We must change the body of our structure definition to group all the mutable fields seperate from the inmutable fields. Lets see how we do this with our `User` structure:
```v
struct User {
  date_created string
  mut:
    email string @[required]
    activated bool = true
    need_password_reset bool
    quota_size int = 1000
}
```
Notice that our list of fields is now divided by the access modifier `mut:`. Fields declared after the `mut:` are mutable and fields that appear before are unmutable. To illustrate this we modified our example with a new field `date_created`. You can now modify fields like `email` and `activated` but we can not change the field  `date_created`.

```v
mut user := User{email: 'joe.doe@mail.com', date_created: '25/OCT/2024'}
// we can modify fields in the mutable section
user.quota_size = 500

// while this will give a compiler error
user.date_created = '20/JAN/2024' //<--- bad!!, compiler error
```

## Visibility {menu:topics}

A structure is only visible under the module namespace it is defined.  For example lets say that our `User` structure is part of a library that we are building to manage user accounts. We are gonna code our functionality under the module namespace "accounts".  We add the line `module accounts` in the top of our source code file to define the module our code belongs to.

To make it visible in other files we need to explicitly tell the compiler if the structure will be exposed (made visible) and which fields are visible. In V we refer to a visible type as a **public** type (is an exported symbol).

To expose our structure to other files and projects we add the `pub` access modifier to mark our structure public:
```v
// File accounts.v
module accounts

// This structure is now public outside this file
// And it exists under the accounts namespace
pub struct User {
  date_created string
  mut:
    email string @[required]
    activated bool = true
    need_password_reset bool
    quota_size int = 1000
}
```

Since our `User` structure now belongs to the `accounts` module we have to use the `accounts` namespace to access our structure in other files. See the [modules](modules.md) section for more details. For example:
```v
// File main.v
//use the accounts module
import accounts

fn main(){
  mut user := accounts.User{email:'joe.doe@mail.com'}
  user.quota_size = 500

  println("User = " + user.email)
}
```

In V a structure declaration is divided into sections according to the visibility and mutability of fields. We saw the section `mut:` for mutable fields, now we add a couple of additional sections for the possible combinations of visibility and mutability. Lets see an example:

```v
// File accounts.v
module accounts

pub struct User {
  date_created string
  mut:
    need_password_reset bool
  pub mut:
    email string @[required]
    quota_size int = 1000
    activated bool = true
}
```

In the above example we have three sections. The default section for inmutable fields in this case only `data_created` is inmutable. The `mut:` marks the start of the mutable fields. In this example we only make the field `need_password_reset` mutable, which means that we can only modify this field inside code that belongs to the **accounts** module. Then we added a third section `pub mut:` as you may have already guess it, this is the section for fields that have a **public** visibility and are also **mutable**.  Now code outside of our accounts module can modife the fields  `email`, `quota_size` and `activated`.

We also have a section for fields that are **public** but **inmutable** for example lets make the field `date_created` visible outside of the accounts module:


{class:v-play}
```v
pub struct User {
  pub:
    date_created string
  mut:
    need_password_reset bool
  pub mut:
    email string @[required]
    quota_size int = 1000
    activated bool = true
}
fn main(){
  // create an instance of our struct
  mut user := User{email:'joe.doe@mail.com'}
  println(user)
}
```

# Methods {menu:topics}

A method is just a [function](functions.md) that we bound (associate) to a structure. We associate a function to structure by adding a receiver argument to a function. Let's start by looking at a regular function that takes a structure as an argument:

{class:v-play}
```v

pub struct User {
  pub:
    date_created string
  mut:
    need_password_reset bool
  pub mut:
    email string @[required]
    quota_size int = 1000
    activated bool = true
}

// define function that takes a User as an argument
fn set_quota(mut usr User, size int){
  usr.quota_size = size
}

fn main(){
  // create an instance of our struct
  mut user := User{email:'joe.doe@mail.com'}

  // call our function and pass our User instance
  set_quota(user, 500)
  
  println(user)
}
```

We use the `set_quota()` function to set the value of the quota on a user ( an `User` struct). In our example we called the function like this `set_quota(user, 500)`. This works perfectly fine!


> Notice that in our `set_quota()` function the `usr` parameter is tagged with `mut` to make it mutable inside our function, even if the varibale `user` in the function main is already declared with `mut`. In **V** we have to explicitly tell the compiler that a function will modify a structure passed as an argument.

Now, here comes the cool part: a **Structure Method**, is like a super convenient shortcut where you pretend that the `set_quota()` function is actually built into the `User` structure itself. Instead of writing: `set_quota(user, 500)` we could use `user.set_quota(500)`.


To convert our `set_quota()` function to use member syntax we just need to change the function declaration to use a receiver parameter:

```v
pub struct User {
  // fields omitted ...
}

// Function set_quota() operates on a structure of type User
// The User structure is available inside the function with the
// variable usr.
pub fn (mut usr User) set_quota(size int){
  usr.quota_size = size
}

```

Notice the new syntax used in the `set_quota` function. The receiver parameter is defined inside parenthesis before the actual function signature. In our example the receiver parameter is `(mut usr User)`. Here, we are creating a mutable variable named `usr` of type `User`. When the function is executed we can use the `usr` variable inside the function code.

```v
fn main(){
  // create an instance of our struct
  mut user := User{email:'joe.doe@mail.com'}

  // call our function using the method syntax...
  user.set_quota(500)
  
  println(user)
}
```

Now we can access the function `set_quota` the same way we access the struct's fields. In our example we used `user.set_quota(500)` to invoke the function. The variable `user` becomes the "receiver" and inside our function our variable `usr` will point to the receiver `user`.

> The visibility rules also apply to the structure's methods. We add `pub` keyword to be able to invoke our method from other files. For example if we place our `User` struct on its own separate file like "accounts.v" (creates a module named accounts).

> **GEEK OUT** Learn more about the Uniform Function Call Syntax - UFCS [here](#ufcs).

There are a couple of rules when creating a function bounded to a structure that you need to follow:

- The function must be declared under the same module as the structure.
- The structure must be defined before we can define a method for the structure.


# Structure embedding {menu:topics;menu-id:embedding;menu-caption:Embedding}

Using **struct embedding** a structure can use the fields and methods of another structure without having to duplicate them. This makes it easier to manage common behaviors and code reusability while avoiding some of the common pitfalls of [inheritance](https://en.wikipedia.org/wiki/Inheritance_%28object-oriented_programming%28) in OOP.

> Struct Embedding is a form of composition where we have a **"has-a" relationship** rather than classical inheritance with a "is-a" relationship.

{class:v-play}
```v
struct Point {
mut:
    x int
    y int
}

fn (mut p Point) move_to(x int, y int)  {
    p.x = x
    p.y = y
}
struct Size {
mut:
    width  int
    height int
}


fn (mut s Size) resize(width int, height int) {
	s.width = width
	s.height = height
}

struct Button {
    Point
    Size
    title string
}

fn main() {
  mut btn := Button{title:"Ok"}
  // fields primitives from the Point struct
  btn.x = 20
  btn.y = 10
  //call function resize() from the Size struct
  btn.resize(100, 24)
  
  println(btn)
}
```

With **field promotion** the fields of the embedded structs (like `Point`, `Size`), are "promoted" to the embedding struct `Button`. This means you can access them directly on an instance of the outer struct as if they were its own fields. For example, the field `btn.x` comes from `Point.x`.

Embedding also promotes the methods. In our example, we can use the method `Size.resize()` with `Button`.

## Shadow structs and name conflicts {menu:topics;menu-id:nameres}

In **V** we can reference a field promoted from an embedded struct using the **type name** as a sort of namespace.

For example `btn.x` can also be referenced as `btn.Point.x`, the same goes for the method resize which is available as `btn.Size.resize()`.

The **type name** is used often to reference the struct:

```v
the_size := btn.Size
println(the_size)
```

If there's a name conflict (e.g., `Button` also had a field named `x`), you have to use the **type name** to access the field name and resolve the ambiguity.

## Promoting from multiple structs {menu:topics;menu-id:ptree}

Fields are promoted from every struct embedded, this is also true when a struct embeds another struct that itself embeds other structs. Fields and methods from all embedded structs will be promoted.

> Remember you'll need to use the [explicit type name](#nameres) access if there are [naming collisions](#nameres) between the embedded structs.

Lets modify our Button example to add a rectangle structure.

```
{class:v-play}
```v
struct Point {
pub mut:
    x int
    y int
}

fn (mut p Point) move_to(x int, y int)  {
    p.x = x
    p.y = y
}
struct Size {
pub mut:
    width  int
    height int
}

struct Rectangle {
  Point
  Size
}

fn (mut s Size) resize(width int, height int) {
  s.width = width
  s.height = height
}

struct Button {
    Rectangle
    title string
}
```
Notice that we added a new `Rectangle` structure that embeds the `Point` and `Size` structures. We modified our `Button` to only embed the `Rectangle` structure. All the fields embedded by `Rectangle` are promoted to our `Button` therefore we can run our original `main()` function and everything still works!

```v
fn main() {
  mut btn := Button{title:"Ok"}
  // fields primitives from the Rectangle.Point struct
  btn.x = 20
  btn.y = 10
  //call function resize() from the Rectangle.Size struct
  btn.resize(100, 24)
  
  println(btn)
}
```

We can use the **type names** to access the hierarchy of structs embedded. For example `btn.Rectangle.Point.x` is the named path to the plain `btn.x` and both of these point to the same value. 

One interesting fact about this field name resolution that may not be obvious is that field promotion also occurs on the embedded structs. We can use this as a short-hand to reference an embedded struct fields without having to walk the embedding chain. For example, `btn.Rectangle.Point.x` can be accessed as `btn.Rectangle.x`. 


======


the error cannot define new methods on non-local type Error occurs because Error is a V builtin, thus already defined (non-locally), and you cannot add a new method to that here.

# More {menu:topics}

## Trailing Struct Literal

The **trailing struct literal** is a special short-hand syntax for a function that has a struct as its only parameter. You can omit the curly-braces when constructing a struct at the same time you call the function:

```v
struct Point {
mut:
    x int
    y int
}

fn do_this(p as point){
  
}

fn main() {
  
  do_this({ x:10, y:20 }) //<-- traditional call
  
  do_this(x:10, y:20) //<-- shorthand...
  
}

```


# GEEK-OUT: Understanding function receivers and Uniform Function Call Syntax {menu:related;menu-id:ufcs;menu-caption:Uniform Function Call Syntax}

While the syntax of associating a function with a struct looks a lot like object-oriented programming (OOP), in reality, what V implements is [Uniform Function Call Syntax (UFCS)](https://en.wikipedia.org/wiki/Uniform_Function_Call_Syntax#Rust_usage_of_the_term).

Uniform Function Call Syntax (UFCS) is a programming language feature that allows functions to be called using dot notation—similar to what you see in object-oriented languages. Fun fact: dot notation predates OOP and is widely used in many procedural languages to access members of records and structs. Examples include C, Pascal, Ada, and others. Modern procedural languages such as D, Rust, Zig, Go, Elm, and Nim implement some form of UFCS.

The actual implementation of UFCS varies between programming languages, but the core idea is the same: a function is associated with a *receiver* value—usually something similar to a `struct` type. Once associated, any value that matches the receiver's data type can use dot notation to invoke the function.

UFCS provides many of the conveniences of OOP's dot notation without the complexity of being forced into the OOP paradigm. This gives developers more flexibility to choose the programming style that works best for them while keeping the language simple.

In **V**, UFCS is used to add a convenient way to call functions on primitive data types like strings, arrays, numbers, structs, and interfaces.

If a data type is defined within a scope that you control, you can associate functions with that type. The syntax is always the same:  
`(receiver Type) fn func_name(<parameter-list>) <return-type>`.  
You can also do this with types defined elsewhere, but in that case, you must define a **type alias**.

```v
type Num = int

// Associate the method with the type alias `Num`
fn (mut b Num) double_it() int {
  return int(b + b) 
}

fn main() {
  mut score := Num(20)
  score = score.double_it()
  println('The score is $score')
}
```