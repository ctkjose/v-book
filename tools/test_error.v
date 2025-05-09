fn test_01(){
	my_error := error('The username selected does not meet the required standards. See https://myapp.com/help/usernames')
	println(my_error)
}

fn main(){
	test_01()
}