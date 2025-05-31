**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>

# Arrays {menu:topics;menu-caption:Intro}

Arrays are a sequential collection of values (same type) that are accessed using an index, making it easy to store and manipulate multiple values under a single name. You can think of them as stack of numbered boxes where we can store values. We use the box number to access its contents or to store a value in the box. In this analogy we can also add or remove boxes to the stack depending on our needs.


# Declarations {menu:topics}

The syntax to declare an array is `var_name := [ VALUE_1, VALUE_2, VALUE_3, .. VALUE_N ]`.

We use the pair of `[ ... ]` (square brackets) to indicate that we have an array. Inside we have the list of initial values separated by a comma. We call each 
value in the array an element. An each element is referenced by its position in the array. The first element is at position 0.

```v
emp_names := ['John', 'Peter', 'Sam']
```

In this example we created an array with three initial values. 

## The data type of an array {menu:topics}

In V, arrays are homogeneous (all elements must have the same type). Just like with [variables](./variables), V will infer the array data type from the type of the first element.

- `[1, 2, 3]`` is an array of ints (`[]int`).
- `['Joe', 'Sam']` is an array of strings (`[]string`).

We can explicitly specify the type for the first element: `[u8(16), 32, 64, 128]`.

## Fixed size or dynamic sized arrays 

Arrays can have a fixed number of elements or have dynamic size where we can add or remove elements as needed.

A **fixed size array** has enough memory to store a given number of values. We can not remove or add elements to a fixed size array.
When we know the number of elements we need, we can create a **fixed size** array:

```v
mut my_array := [10]string
println(my_array)
```

In this example our the array `my_array` has 10 elements (index 0...9). We can not add or remove elements from a fixed length array. In the 

A **dynamic sized array** starts with no elements and we add or remove elements as needed. Creating an empty array requires us to indicate the data type of the array since V can not infer a data type.

```v
mut my_array := []string{}
```

In the example, we used the syntax `[]string{}` to create our dynamic array. Here, the empty square brackets `[]` creates the empty array the literal array is followed by the *data type* to the values to be stored in our array. In this example we made a dynamic array of `string` values. The declaration is followed by the initialization `{}`. In this example since we do not have any particular requirements our initialization is left blank.

## Initialization {menu:topics}

The initialization lets us specify key aspects of an array like the capacity. Lets see an example:
```v
mut my_array := []string{cap: 10}
```
The initialization uses a [struct](./structs.md) like syntax `{}` where we specified the fields that control the creation of the array. The configuration fields are:
- `cap` An integer that specifies the maximum number of elements the array can have.
- `len` An integer that specifies the initial number of elements to be created.
- `init` An expression with the value used for the initial elements created.

In this example we specified a maximum capacity of 10 elements using the `cap` field.

Lets see another example:

{class:v-play}
```v
fn main(){
	mut my_array := []string{cap: 10, len:5, init:'UNKNOWN'}
	println(my_array) 
	// The output is 
	// ['UNKNOWN', 'UNKNOWN', 'UNKNOWN', 'UNKNOWN', 'UNKNOWN']
}
```
Here, the array `my_array` can have a maximum of 10 elements and we initialize it with 5 elements that will have the value 'UNKNOWN'. This particular example we can add element up to 10 but since the array was initialized with five elements that means we can only add 5 more elements.


# Access elements of an array {menu:topics}

You can access a specific array element by referring to the index number.

In V, array indexes start at 0. That means that [0] is the first element, [1] is the second element, etc.

{class:v-play}
```v
fn main(){
	nums := [1, 2, 3]
	println(nums) // `[1, 2, 3]`
	println(nums[0]) // `1`
	println(nums[1]) // `2`
}
```

> The mutability of the array [variable](./variables.md) controls if we can change, add or remove elements from the array.

We can also change the value of a specific array element by referring to the index number. Remember that an array must be mutable to be able to modify its elements.

{class:v-play}
```v
fn main(){
	mut nums := [1, 2, 3]
	
	nums[1] = 5
	println(nums) // `[1, 5, 3]`
}
```

# Research

block [100_000]u8