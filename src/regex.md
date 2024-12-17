

```v
import regex

const r_punctuation = '\\X002A\\X002B\\X003F\\X005E\\X0021\\X007E\\X007C\\X0060\\X0024\\X002E\\X0022\\X0027\\X005C\\X002C\\X0028\\X0029\\X005B\\X005D\\X007B\\X007D-_@%:;<>'
text := 'hello [jo-e] cpap.apaz'
mut query := r'(\X005B.*\X005D)'
//query = r'[A-Za-z0-9\s$r_punctuation]+'
mut re := regex.regex_opt(query) or { panic(err) }
println(text)
println(re.get_query())


start, end := re.find(text)
println('start: ${start}, end: ${end}')

mut gi := 0
for gi < re.groups.len {
	if re.groups[gi] >= 0 {
		println('${gi/2}(${re.groups[gi]},${re.groups[gi+1]}): ${text[re.groups[gi]..re.groups[gi + 1]]}')
	}
	gi += 2
}


if start >= 0 {
	println('[0] (${start},${end}): ${text[start..end]}')
	matches := re.get_group_list() // this is the utility function
	if matches.len > 0 {
		for i in 0 .. matches.len {
			println('[${i+1}] (${matches[i].start},${matches[i].end}): ${text[matches[i].start..matches[i].end]}')
		}
	}
} else {
	println('Not matched')
}
```