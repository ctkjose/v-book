# Structures

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

## Using a structure

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

### Making a field required
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

### Accessing fields
We use the `.` to access a field value.  For example:
```
email := user.email
if !user.activated {
  println("User \"${user.email}\" is not active.")
}
```

## Visibility and mutability
Visibility and mutability are two important concepts that we need to understand when using our structures. Visibility refeers to where is our structure accesible and mutability is what can be modified. By default the V compiler will produce the simplests and safer code, that means that:

First structures are only visible in the module they were created, our structure is **local** to the module. 

> Remember if a source file doesnt specify a module name with the `module` keyword that code will executed under the default **main** namespace.

Second once our structure instance is created the values can not be modified, the structure is **inmutable**.

In V we explicitly control when a structure's field is mutable, when the structure itself is mutable and when we expose our structure to other modules.

### Mutability
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

### Visibility

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

In V a structure declaration is divided into sections according to the visibility and mutability of fields. We saw the section `mut:` for mutable fields, now we add a couble of additional sections for the possible combinations of visibility and mutability. Lets see an example:

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
```v
// File accounts.v
module accounts

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
```

## Methods
A method is just a [function](functions.md) that we bound (associate) to a structure. We associate a function to structure by adding a receiver argument to a function. Let's start with a regular function that does something with a structure:
```v
// File main.v
import accounts

// define function that takes a User as an argument
fn set_quota(mut usr accounts.User, size int){
  usr.quota_size = size
}

fn main(){
  // create an instance of our struct
  mut user := accounts.User{email:'joe.doe@mail.com'}

  // call our function and pass our User instance
  set_quota(user, 500)
}
```

> Notice that in our `set_quota()` function the`usr` parameter is tagged with `mut` to make it mutable inside our function. When we created our `User` instance `mut user` we made it mutable only inside the function `main`, we have to explicitly tell the V compiler that a function will modify a structure passed as an argument.

To bound our `set_quota()` function to user we are going to change the function to use a receiver parameter:

```v
// File accounts.v
module accounts

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

Notice a new syntax used in the `set_quota` function. The receiver parameter is defined inside parenthesis before the actual function signature. In our example the receiver parameter is `(mut usr User)` , inside our function we have available a variable named `usr` which is a mutable instance of the structure `User`. The function `set_quota`  now becomes a member of the `User` structure.

The visibility rules also apply to the structure's methods. We add `pub` keyword to be able to invoke our method from outside the accounts module.

From our main code we can now use the `set_quota()` function like this:
```v
// File main.v
import accounts

fn main(){
  // create an instance of our struct
  mut user := accounts.User{email:'joe.doe@mail.com'}

  // call the set_quota function on the structure instance user
  user.set_quota(500)
}
```


There are a couple of rules when creating a function bounded to a structure that you need to follow:

- The function must be declared under the same module as the structure.
- The structure must be defined before we can define a method for the structure.


## Composing Structures

Using struct composition a structure can use the fields and methods of another structure without having to duplicate them. This makes it easier to manage common behaviors and code reusability while avoiding some of the common pitfalls of [inheritance](https://en.wikipedia.org/wiki/Inheritance_(object-oriented_programming)) in OOP

```v
// File main.v

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
}
```

In our `main()` function notice that fields and methods defined in the `Point` and `Size` structs are now avilable as part of the `Button` structure.

the error cannot define new methods on non-local type Error occurs because Error is a V builtin, thus already defined (non-locally), and you cannot add a new method to that here.
