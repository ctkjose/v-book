
{doc-type:doc;doc-version:1.0;doc-title:Strings}
**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>

# Strings  {menu:topics}

In the V programming language, a string is a sequence of characters used to represent text.

> **Encoding:** All strings in V are UTF-8 encoded. This allows them to represent a vast range of characters from virtually all writing systems in the world.

# Creating Strings {menu:topics}

Strings can be created in V using either single or double quotes. The V formatting tool.

```v
my_single_quoted_string := 'Hello, V!'
my_double_quoted_string := "This also works."
string_with_single_quote := "It's a string with a single quote."
```

> In **V**, we prefer to use single quotes, but either one works.

bla, bla...



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