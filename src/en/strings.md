
{doc-type:doc;doc-version:1.0;doc-title:Strings}
**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>

# Strings  {menu:topics}

In the V programming language, a string is a sequence of characters used to represent text.

> **Encoding:** All strings in V are UTF-8 encoded. This allows them to represent a vast range of characters from virtually all writing systems in the world.

# Creating Strings {menu:topics}

A string [variable](./variables.md) is defined by assigning a literal string using either single or double quotes to delimit the start and end of the string.

{class:v-play}
```v
fn main(){
	my_email := 'jose@example.com'

	message := "This is a message in double quotes."

	my_string_with_single_quote := "It's a string with a single quote."

	println(my_string_with_single_quote)
}
```
In this example we created three string variables. Notice that in `my_string_with_single_quote` the string value contains a single quote, therefore we use double quotes to delimit the start and end of the string.

> In **V**, we prefer to use single quotes, but either one works.


# Mutability of strings {menu:topics}

We need to make the distinction between the string data and a string variable. A string variable holds our string. The contents of the [variable](./variables.md) can be modified by adding the `mut` prefix.

```v
fn main(){
	mut msg := 'hello 🌎' //<-- create a string variable
	msg = 'Hello 🌎' //<-- assign a new string to the variable
}
```
In **V**, strings are immutable; the data of the string itself can not be modified. However, this is different to the mutability of the variable holding the string data. Like we saw in the previous example we can assign a new string to a variable if we declare the [variable](./variables.md) with `mut`.


Any operation on strings produce a new string. 

# String Properties {menu:topics}

In **V**, strings have fields and methods similar to [structs](./structs.md) that we can use to inspect or operate on strings.


## Length {menu:topics;class:v-member-string}

The length of a string (number of bytes) can be obtained using the `.len` field.

{class:v-play}
```v
fn main(){
	message := 'Hello'
	println(message.len) // Output: 5
}
```

Byte Indexing: You can access individual bytes of a string using square bracket notation. This returns a u8 (byte) value. It's important to note that for UTF-8 strings, indexing by byte does not directly correspond to character indexing if the string contains multi-byte characters.

```v
fn main(){
greeting := 'Hi!'
first_byte := greeting[0] // H as a u8 value
println(first_byte)
println(first_byte.ascii_str()) // To convert the u8 back to a single-character string (if ASCII)
}
```

Accessing Runes (Unicode Code Points): To work with individual Unicode characters (runes), V provides the .runes() method. This method returns an array of rune (which is an alias for u32).

```v
fn main(){
unicode_string := 'Hello 🌎'
runes_array := unicode_string.runes()
println(runes_array.len)       // Output: 7 (H, e, l, l, o,  , 🌎)
println(runes_array[6])        // The rune for 🌎
println(string(runes_array[6])) // Convert the rune back to a string
}
```


# Raw Strings

Raw Strings: V also supports raw strings, which are useful when you want to include backslashes or other special characters literally without escaping them. Raw strings are prefixed with r.

```v

fn main(){
	raw_path := r'C:\Users\YourName\Documents'
	multiline_raw_string := r'''
This is a
multi-line
raw string.
'''

	println(raw_path)
	println(multiline_raw_string)
}
```