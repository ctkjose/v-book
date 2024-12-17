import strings

fn main() {
	groups := ['v1', 'v2']
	str_in := '😎 jose is here'
	str_rep := 'Hello \$2, how are you doing=\$1'
	
	
	mut res := ''
	//mut i := 0
	mut out := strings.new_builder(str_in.len)
	
	mut runes := str_rep.runes()
	println(runes)
	
	mut ch := ` `
	mut st := 0
	mut num := []rune
	mut idx := -1
	
	for i in 0..runes.len {
		ch = runes[i]
		//println('ch[$i]=$ch')
		
		if st == 0 {
			if ch == `$` {
				st = 1
				num.clear()
				idx = -1
				continue
			}	
		}else if st == 1 {
			if ch >= `0` && ch <= `9` {
				
				num << ch
				idx = num[0..].string().i16() 
				println('idx=$idx')
				continue
			}else{
				st = 0
				println('commit idx=$idx')
				
				if idx >= 1 && idx <= groups.len {
					g := groups[idx-1]
					out.write_string(g)
				}else{
					out.write_string('@')
				}
				idx = -1
			}
		}
		
		out.write_rune(ch)
		
	}
	
	if idx >= 1 && idx <= groups.len {
		g := groups[idx-1]
		out.write_string(g)
	}
	
	println(out.str())
}