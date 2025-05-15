
{doc-type:doc;doc-version:1.0;doc-title:Strings}
**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>

# Strings  {menu:topics}

In **V**, a string is a sequence of characters used to represent text.

V uses the [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoding for strings. We will dive deeper into [unicode and encodings](#encodings) later, but for now, let's starts with a simple overview of UTF-8. In early computing history, we had one-byte character systems that were limited to 256 symbols, mostly used for the Latin characters and basic symbols. UTF-8 is a multi-byte system that allows us to represent thousands of symbols needed for all the languages and it even has space left for emojis.

For now we can think of the string variables as a series of bytes ('u8'). However, it's important to note that not all characters use one byte. In fact, only the traditional 127 Latin characters of [ASCII](https://en.wikipedia.org/wiki/ASCII) use a single byte, everything else is multiple bytes (two or more).

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
In this example, we created three string variables. Notice that in `my_string_with_single_quote` the string value contains a single quote, therefore we use double quotes to delimit the start and end of the string.

> In **V**, we prefer to use single quotes, but either one works.

{class:v-play}
```v
fn main(){
	mut msg := 'hello 🌎' //<-- string with  multi-byte unicode characters
	println(msg)
}
```

## Escaping sequences

In **V**, escape sequences are special character combinations preceded by a backslash `\`. They are used to represent characters that are difficult or impossible to type directly within string literals. 

A common use of escape sequences is to include a single quote inside a single-quoted string or a double quote inside a double-quoted string. In such cases, we prefix the quote with a backslash (`\`) to tell the compiler to treat it as a regular character, not as a string delimiter.

{class:v-play}
```v
fn main(){
	mut msg := 'V\'s library are awesome!!!'
	println(msg)
}
```

To add a newline character we use the escape sequence `\n` on Mac\Linux and `\r\n` on Windows:

{class:v-play}
```v
fn main(){
	mut msg := 'Hi there!.\nWelcome to the V community...'
	println(msg)
}
```

Another useful escape sequence is the hexadecimal escape sequence `\x####` that we can use to represent raw bytes in a string. For example the character `J` is the number 74 in UTF-8 which is `4A` in hexadecimal, we can use an escape sequence `\x4a` to add the byte in the string.

{class:v-play}
```v
fn main(){
	mut s := 'Hi \x4aose' //<-- will output "Hi Jose"
	println(s)
}
```

In this example, we use `\x4A` to insert the byte corresponding to the character `J`. While this works, it’s not the best practice for representing characters. The `\x` escape sequence is more suitable for working with raw binary data.

To represent characters, it’s better to use the Unicode escape sequence `\u####`, which allows you to express any 16-bit Unicode character. In our example, the letter `J` has the code point *U+004A*, so we can use the escape sequence `\u004A` instead.

{class:v-play}
```v
fn main(){
	mut s := 'Hi \u004A\u006F\u0065' //<-- will output "Hi Joe"
	println(s)
}
```

> **Sorry!** Only 16-bit unicode characters can be used with `\u`;  Emojis and others characters that use more than two bytes are not supported.

Here's a table of the common escape sequences in **V**:

| Escape Sequence | Description |
| --- | --- |
| `\n` | Newline, Moves the cursor to the beginning of the next line. |
| `\r` | Carriage return, Moves the cursor to the beginning of the current 1  line (without advancing). |
| `\t` | Horizontal tab, Moves the cursor to the next horizontal tab stop. |
| `\v` | Vertical tab, Moves the cursor to the next vertical tab 2  stop (behavior can vary). |
| `\b` | Backspace, Moves the cursor one position backward. |
| `\f` | Form feed, Advances the printer to the next logical page (behavior can vary). |
| `\\` | Backslash, Represents a literal backslash character. |
| `\'` | Single quote, Represents a literal single quote character (used within single quotes). |
| `\"` | Double quote, Represents a literal double quote character (used within double quotes). |
| `\?` | Question mark, Represents a literal question mark character (useful to avoid trigraphs). |
| `\0` | Null character, Represents the null terminator, often used to mark the end of a string. |
| `\a` | Alert (bell), Produces an audible or visible alert (behavior depends on the system). |
| `\uhhhh` | Unicode code-point, Represents any 16-bit (2 bytes) unicode characters with the hexadecimal value hhhh of the code-point (e.g., \u0041 is 'A'). |
| `\xhh` | Hexadecimal value, Represents a character with the hexadecimal value hh (e.g., \x41 is 'A'). |
| `\ooo` | Octal value, Represents a character with the octal value ooo (e.g., \101 is 'A'). |


# Mutability of strings {menu:topics}

We need to make the distinction between the string data and a string variable. A string variable holds our string. The contents of the [variable](./variables.md) can be modified by adding the `mut` prefix.

```v
fn main(){
	mut msg := 'hello 🌎' //<-- create a string variable
	msg = 'Hello 🌎' //<-- assign a new string to the variable
}
```
In **V**, strings are immutable; the data of the string itself can not be modified. However, this is different to the mutability of the variable holding the string data. As we saw in the previous example, we can assign a new string to a variable if we declare the [variable](./variables.md) with `mut`.

Any operation on strings always produces a new string and that's ok for most programs we write. For critical performance we will look into a string builder that is optimized for memory use and speed.

# String concatenation and interpolation {menu:topics;menu-id:concatenation}

The process of combining/adding two or multiple strings to form a single string is called concatenation. The simplest way to concatenate strings in **V** is using the `+` operator.

{class:v-play}
```v
fn main(){	
	name := 'Joe'
	message := 'Hello ' + name
	println(message) //<-- Outputs "Hello Joe"
}
```

In this example, we have two strings `'Hello '` and the string in the variable `name` and we combine (concatenate) them to form a third new string that gets assigned to the variable `message`.

With a mutable string variable we can use the append operator `+=` to add a string to an existing string.

{class:v-play}
```v
fn main(){
	mut message := 'Hello '
	message += 'Joe'
	println(message) //<-- Outputs "Hello Joe"
}
```

When doing concatenation the receiving variable must be a string or a new variable being declare. Both values must be strings, **V** does not do implicit type conversion.

To concatenate numbers or other values we must convert does values to string first. Numbers in V implement the method `.str()` to convert them to a string. Lets see an example:

{class:v-play}
```v
fn main(){	
	code := 245
	mut message := 'The code is ' + code.str()
	println(message) //<-- Outputs "The code is 245"
}
```

## Length Property {menu:topics;class:v-member-string}

The length of a string (number of bytes) can be obtained using the `.len` field.

{class:v-play}
```v
fn main(){
	message := 'Hello 🌎'
	println(message.len) // Output: 10
	
	if message.len > 0 {
		println('Message is not empty...')
	}
}
```

In this example, we use the [structs](./structs.md) syntax to operate on a string. **Notice** that the string length is 10 and not 7, this is because the `len` property counts bytes and not characters.


## Encodings and Code Points {menu:topics;menu-id:encodings}

In **V**, **strings** are just a sequence of bytes for example the string "hello" is made of the corresponding 4 bytes (where a byte is `u8` number) for each character on the string, in this case `"h"=104 (0x68)`, `"e"=101 (0x65)`, `"l"=108 (0x6C)`, `"l"=108 (0x6C)`, `"o"=111 (0x6F)`. 

{class:v-play}
```v
s := 'hello'
println(s.len) //<-- will ouput 4

ch := s[0] //<-- get byte at position 0
println(ch) //<-- will output 104  (0x68)
```

> Thinking of strings as an array of `u8` is a great way to visualize them. In fact we will see later that we can operate on strings in a similar way we do with [arrays](./arrays.md).

For basic strings without [unicode characters](https://en.wikipedia.org/wiki/Unicode) a character takes exactly one byte (8-bits) and there are 256 (0-255) possible symbols that can be represented by them. What character you see in your screen depends on the **encoding**. A **character encoding** is a system where we map or assign a unique numerical value to each character. The encoding tells how many bits are used to represent each symbol. Like you can imagine there are many encodings and depending what encoding your application (terminal, browser, text editor) or operating system is configured to use is what you actually see.

The basic [ASCII](https://en.wikipedia.org/wiki/ASCII) encoding used 7 bits ( which fits in 1 byte, *an `u8` in V* ) to represent the basic latin alphabet with 128 characters. With the need to represent more symbols later encodings like [ASCII-Extended, ISO 8859-1, Windows-1252](https://en.wikipedia.org/wiki/Extended_ASCII) used 8 bits ( 1 byte, *which is an `u8` in V* ) to represent 256 symbols. These encodings in particular ISO 8859-1 covered most latin based languages and Western European languages. Up to this point in history one byte represented one character on the **string**. Nevertheless this was not enough to cover all other languages like Asians, Greek, Cyrillic, Arabic and many more.

In 1989 the [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoding  was created to solve this issue. In UTF-8 a character can be represented with 1 byte or up-to 4 bytes. One byte covers the original 128 characters of ASCII. With the addition of two bytes a total of 1,920 more symbols were added which covers almost all Latin-script alphabets, Greek, Cyrillic, Arabic and more. Three bytes added 61,440 characters which covered Japanese, Chinese and Korean characters. With four bytes, the we got emojis and many more symbols. UTF-8 quickly became the most common encoding and is the encoding used by **V**.

To represent characters beyond the first 127 characters in UTF-8 we use from 2 to 4 bytes. For example the character `h` takes one byte with a numerical value of `104` or `0x68` ; the character `Ü` takes two bytes   `0xC39C` and the emoji 🌎 takes four bytes `0xF09F97BA`.

A code-point is a reference number assigned to a character in the unicode tables and it is written as "U+" and the character number in hexadecimal. For example the character `h` is code-point `U+0068`, the character `Ü` is code-point `U+00DC` and 🌎 is `U+1F5FA`.

In **V**, we use a `u8` number to represent a byte, but how do we represent multi-byte characters in V?

## Runes {menu:topics}

A [**rune**](https://en.wikipedia.org/wiki/Runes) is a programming term for a `u32` number that represents a Unicode code-point. When working with unicode strings we no longer work with the underlying bytes, but instead we operate on the **runes** (code-points) that make up the string.

In **V**, we use the syntax &#96;🌎&#96; to represent **runes**.

{class:v-play}
```v
fn main(){
	s := '🌎' //<-- this is a string with unicode characters

	rune := &#96;🌎&#96; //<-- this is a rune
}

```

We can convert a string into an [array](/.arrays.md) of runes using the `.runes()` method on a string. Lets see an example:

{class:v-play}
```v
fn main(){
	msg := 'hello 🌎'
	mut u_msg := msg.runes;

	println(u_msg[6]) //<-- output 🌎
}
```

In the example, we created the variable `u_msg` to hold the array of runes. Now we can access multi-byte characters by their index. The 🌎 emoji is at position 6 on the string `msg`, so we use `u_msg[6]` to access the rune at that position.

When manipulating a string that may include multi-byte unicode characters we want to use the runes array instead. Since the runes is just another [array](./arrays.md) we can do all the basic array operations on it.

Lets see an example of how to get the length of a unicode strings:

{class:v-play}
```v
fn main(){
	msg := 'hello 🌎'
	println(msg.length) //<-- prints 10 (bytes)...
	
	mut u_msg := msg.runes;
	println(u_msg.len) //<-- prints 7 (characters)...
}
```

Another useful feature of arrays that we use with strings is slicing.

{class:v-play}
```v
fn main(){
	mut u_msg := msg.runes;
	
	part :=  u_msg[0..5]
	println(part) //<-- prints the array ['h','e','l','l','o']
	
	s := part.string()
	println(s) //<-- outputs "hello"	
}
```

In this example the slice `[0..5]` grabs 5 runes starting at position 0 and returns a new array of 5 runes. Later we use the method `.string()` to convert a runes array back to a string.


# More on  {menu:topics}

In **V**, strings have fields and methods similar to [structs](./structs.md) that we can use to inspect or operate on strings.

The official documentation of string methods is available [here](https://modules.vlang.io/strings.html).






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