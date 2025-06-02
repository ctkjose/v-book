**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>

# Compile time preprocessing {menu:topics;menu-caption:Intro}

During compilation V will perform a preprocessing of the source code. In this phase we can use preprocessing directives to modify the source code based on certain conditions like type of operating system or by special indicators specified using macros.

# Basic macros {menu:topics}

A macro is essentially a named value or placeholder that we can use in our code and gets replaced by the preprocessor before the actual compilation of the code begins. Macros are commonly used to indicate a condition or feature that changes how we need to compile the code. For example code running on Windows may need to do something different that it would on mac and linux. For example, V includes the macros like `macos`, `linux`, `windows` to indicate which operating system we are compiling for. 

In V, we use the `-d` option to define a custom macro. For example `v -d use_server run ./myproject` adds the macro `use_server` with a boolean value of true.

> A macro defined with `-d` will be send to the C compiler using `-D name`.


# Conditional compilation

In V, we use the `$if` preprocessing directive to make basic decisions at compile-time of what code is include.

```v
$if constant ? {
	code...
}
```
```v

$if linux || macos {
	...
	
}
// magnitude returns the magnitude, also known as the length, of the vector.
pub fn (v Vec2[T]) magnitude() T {
	if v.x == 0 && v.y == 0 {
		return T(0)
	}
	$if T is f64 {
		return math.sqrt((v.x * v.x) + (v.y * v.y))
	} $else {
		return T(math.sqrt(f64(v.x * v.x) + f64(v.y * v.y)))
	}
}

fn swap_bytes[T](input T) T {
	$if T is u8 {
		return input
	} $else $if T is i8 {
		return input
	} $else $if T is byte {
		return input
	} $else $if T is u16 {
		return swap_bytes_u16(input)
	} $else $if T is u32 {
		return swap_bytes_u32(input)
	} $else $if T is u64 {
		return swap_bytes_u64(input)
	} $else $if T is i16 {
		return i16(swap_bytes_u16(u16(input)))
	} $else $if T is i32 {
		return i32(swap_bytes_u32(u32(input)))
	} $else $if T is int {
		return i32(swap_bytes_u32(u32(input)))
	} $else $if T is i64 {
		return i64(swap_bytes_u64(u64(input)))
	} $else {
		panic('type is not supported: ' + typeof[T]().str())
	}
}


$if T is $array_fixed {
	
}
```


# Built-in flags

- `debug`
- `prod`
- `verbose` => The `-v` options was used.

- `macos` => True, if compiling for MacOs.
- `windows`, `windows_7` => True, if compiling for MS Windows.
- `linux` => True, if compiling for Linux.
- `freebsd`, `openbsd`, `netbsd` => True, if compiling for BSD.
- `dragonfly`, `termux`, `qnx`, `solaris`, `serenity`
- `haiku` => BeOS
- `android`
- `apk`
- `ios`
- `vinix`

- `gcc`
- `msvc`
- `tinyc`
- `musl`
- `big_endian`, `little_endian`
- `nofloat`
- `amd64`, `x64`, `x32`, 
- `cross` ??
- `prealloc`
- `gcboehm`, `autofree`


# Compile time pseudo-constants {menu:topics}

- `@FN` => a string with the name of the current V function.
- `@METHOD` => a string with ReceiverType.MethodName.
- `@MOD` => a string with the qualified method name of the current module.
- `@STRUCT` => a string with the name of the current V struct.
- `@FILE` => the absolute path of the V source file.
- `@FILE_DIR` => the absolute path of the folder of the source file.
- `@PRJ_DIR` => the absolute path of the project folder.
- `@LINE` => a string with the V line number where it appears.
- `@FILE_LINE` => like `@FILE:@LINE`, but the file part is a relative path.
- `@LOCATION` => a string with file, line and name of the current type + method; suitable for logging.
- `@COLUMN` => a string with the column where it appears.
- `@BUILD_DATE` => replaced with the build date, for example '2024-09-13' .
- `@BUILD_TIME` => replaced with the build time, for example '12:32:07' .
- `@BUILD_TIMESTAMP` => replaced with the build timestamp, for example '1726219885' .
- `@VEXE` => a string with  the path to the V compiler.
- `@VEXEROOT`  => a string with the path to the folder where the V executable is.
- `@VHASH`  => replaced with the shortened commit hash of the V compiler (as a string).
- `@VCURRENTHASH` => Similar to `@VHASH`, but changes when the compiler is recompiled on a different commit (after local modifications, or after using git bisect etc).
- `@VMOD_FILE` => replaced with the contents of the nearest v.mod file (as a string).
- `@VMODHASH` => is replaced by the shortened commit hash, derived from the .git directory next to the nearest v.mod file (as a string).
- `@VMODROOT` => will be substituted with the *folder*, where the nearest v.mod file is (as a string).

> Note: `@BUILD_DATE`, `@BUILD_TIME`, `@BUILD_TIMESTAMP` represent times in the UTC timezone. By default, they are based on the current time of the compilation/build. They can be overridden by setting the environment variable `SOURCE_DATE_EPOCH`. That is also useful while making releases, since you can use the equivalent of this in your build system/script: `export SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct) ;` , and then use `@BUILD_DATE` etc., inside your program, when you for example print your version information to users. See also https://reproducible-builds.org/docs/source-date-epoch/ .

