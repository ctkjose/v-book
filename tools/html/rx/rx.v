module rx

import regex
import strings

pub struct RegEx {
pub mut:
	r		regex.RE
	valid	bool
	err		string
}

pub fn new (strx string) RegEx {
	mut re := RegEx {
		r: regex.new()
		valid: true
	}
	
	re.r.compile_opt(strx) or { 
		re.valid = false
		re.err = err.msg()
	 }
	
	return re
}



pub struct RegExMatchEntry {
pub:
	idx		int
	start 	int = -1
	end   	int = -1
	value	string
}


pub struct RegExMatch {
pub mut:
	idx		int
	start 	int = -1
	end   	int = -1
	indices	[]int
	groups	map[string]RegExMatchEntry
}

// Performs a regular expression search and replace
// Backreferences using `$1` are supported.
// replace return a string where the matches are replaced with the repl_str string,
// this function supports groups in the replace string
pub fn replace(pattern string, str_repl string, str_in string) string {
	
	//println('replace($pattern, $str_in, $str_repl)')
	mut re := new(pattern)
	mut matches := re.exec(str_in)
	//println(matches)
	
	mut res := strings.new_builder(str_in.len)
	mut p := 0

	for m in matches {
		if m.start >= 0 && m.end > m.start {
			
			//println("find match in: ${m.start},${m.end} [${str_in[m.start..m.end]}]")
			
			if p < m.start {
				res.write_string(str_in[p..m.start])
			}
			
			repl := re.replace_with_string(m, str_repl, str_in.len)
			//println("repl res: $repl")
			
			res.write_string(repl)
			
			p = m.end
		} else {
			break
		}
		
	}
	
	if p >= 0 && p < str_in.len {
		res.write_string(str_in[p..])
	}
	
	return res.str()
}

fn (re &RegEx) replace_with_string(entry RegExMatch, str_rep string, str_sz int) string {

	mut out := strings.new_builder(str_sz)
	mut runes := str_rep.runes()
	
	mut ch := ` `
	mut st := 0
	mut num := []rune{}
	mut idx := ''
	
	for i in 0..runes.len {
		ch = runes[i]
		//println('ch[$i]=$ch')
		
		if st == 0 {
			if ch == `$` {
				st = 1
				num.clear()
				idx = ''
				continue
			}	
		}else if st == 1 {
			if ch >= `0` && ch <= `9` {
				
				num << ch
				idx = num[0..].string()
				continue
			} else { 
				st = 0
				if idx.len>0 && idx in entry.groups {
					out.write_string(entry.groups[idx].value)
				}
				
				idx = ''
			}
		}
		
		out.write_rune(ch)
		
	}
	
	if idx.len>0 && idx in entry.groups {
		out.write_string(entry.groups[idx].value)
	}

	return out.str()
}

/*
pub fn find_between_pair_rune(input string, start rune, end rune) string {
	mut marks := 0
	mut start_index := -1
	runes := input.runes()
	for i, r in runes {
		if r == start {
			if start_index == -1 {
				start_index = i + 1
			}
			marks++
			continue
		}
		if start_index > 0 {
			if r == end {
				marks--
				if marks == 0 {
					return runes[start_index..i].string()
				}
			}
		}
	}
	return ''
}
*/

pub fn (re &RegEx) exec(str_in string) []RegExMatch {
	
	mut i := -1
	
	mut out := []RegExMatch{}
	mut p := 0
	
	mut r := &re.r;
	mut start, mut end :=  r.find_from(str_in, p)
	
	
	for start >= 0 {
		i+=1
		mut gi := 0
		
		mut m := RegExMatch{idx: i, start:start, end: end}
		mut g_idx := 0
		mut g_start := 0
		mut g_end := 0
		
		
		m.groups['0'] = RegExMatchEntry{
			idx:0, start: start, end: end, value: str_in[start..end] }
		
		for gi < r.groups.len {
			if r.groups[gi] >= 0 {
				
				g_idx = (gi/2)+1
				g_start = r.groups[gi]
				g_end = r.groups[gi+1]
				
				m.indices << g_start
				m.indices << g_end
				
				m.groups[g_idx.str()] = RegExMatchEntry{
					idx: (gi/2)+1,
					start: g_start, 
					end: g_end,
					value: str_in[g_start..g_end]
				}
				
			}
			gi += 2
		}
		
		for name in r.group_map.keys() {
			g_idx = r.group_map[name]-1
			g_start = r.groups[g_idx * 2]
			g_end = r.groups[g_idx * 2 + 1]
			
			m.groups[name] = RegExMatchEntry{
				idx: g_idx+1,
				start: g_start, 
				end: g_end,
				value: str_in[g_start..g_end]
			}
		}
		out << m
		
		p = end
		start, end =  r.find_from(str_in, p)
		
	}
	
	return out
}

fn (mut re RegEx) test1(pattern string) {
	println("hello")
}