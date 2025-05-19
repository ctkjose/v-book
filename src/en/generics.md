

# Monomorphic function

fn simple_fn[T](param T) T {
	return param
}

value := simple_fn(1)


struct GenericStruct[T] {
	value T
}

fn (g GenericStruct[T]) generic_method() {
	return
}


# Type reflection

type Number = int

fn is_number[T](data T) bool {
	$if T is Number {
		return true
	} $else {
		return false
	}
}

println(is_number(Number(0)))