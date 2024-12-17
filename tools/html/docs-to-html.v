import md
import rx
import regex




fn test(pattern string) {
	println("hello")
}

fn main() {
	println("alive...")
	
	test_md()
	//test_regex()
}
fn test_md(){
	str_md := '
	# Welcome to V Lang
	
	Welcome to V this is a test\r\njose
	
	'
	
	mut mds := md.State {
		src: str_md
	}
	
	mds.preflight()
	println(mds.src)
	
}
fn test_regex(){
	mut s := 'Month April 15, 2003  May 20, 2025'

	mut r2 := regex.regex_opt('\r\n?') or { panic(err) }
	mut s2 := r2.replace('jose\r\ntest\rcuevas', '@') 
	println('s2=($s2)')
	
	s2 = rx.replace('\r\n?', '@', 'jose\r\ntest\rcuevas')
	println('s2=($s2)')
			
	mut r1 := regex.regex_opt('(\\w+) (\\d+), (\\d+)') or { panic(err) }
	
	mut s1 := r1.replace_simple(s, '\\0=\\1') 
	println('v.regex.replace_simple($s1)')
	
	// Uses the regex backreference syntax in replace capture groups
	
	s1 = r1.replace(s, '\\0=\\1') 
	println('v.regex.replace($s1)')
	
	s = rx.replace('(\\w+) (\\d+), (\\d+)', '\$1=\$2', s)
	println('rx.replace($s)')
	
	
	
	mut text := 'The quick brown Fox jumps Over The Lazy Dog'
	text = 'jose\r\ntest\rcuevas'
	
	//mut re := rx.new('quick (?P<color>brown?).?')
	mut re := rx.new('\r\n?')
	matches := re.exec(text)
	
	println('Matched= ${matches.len}')
	if re.err.len > 0 {
		println(re.err)
	}
	//mut group := RegExMatchEntry{}
	//mut match := RegExMatch{}
	
	for m in matches {
		//match := matches[i]
		for name in m.groups.keys() {
			group := m.groups[name]
			println('[$name] (${group.idx}, ${group.start},${group.end}): ${group.value}')
		}
	}
}