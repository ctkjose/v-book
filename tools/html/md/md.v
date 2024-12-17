module md
import rx



// \u0028 \u0029 ( )
// \u005B \u005D [ ]
// \u007B \u007D { }
// *       +       ?       ^       !       ~       |
// \u002A  \u002B  \u003F  \u005E  \u0021  \u007E  \u007C
// `       $       .       "       '       \       ,
// \u0060  \u0024  \u002E  \u0022  \u0027  \u005C  \u002C

const rx_punctuation = '\\X002A\\X002B\\X003F\\X005E\\X0021\\X007E\\X007C\\X0060\\X0024\\X002E\\X0022\\X0027\\X005C\\X002C\\X0028\\X0029\\X005B\\X005D\\X007B\\X007D-_@%:;<>'


//const (
	
	//rx_st = r'(\X005C\X0022A-Za-z0-9_\.\X005C\X0022|A-Za-z0-9_|\-| |\:|\X0027|\X002E|\$|\[|\]|\_|\+|\-|\=|\%|\&|\?|\\|\#|\!|\@|\~|^|\{|\}|\;|\/|\<|\>|\(|\)|\,)*'

	//wrxw  = r'[A-Za-z0-9\s${rx_punctuation}]*'
//)

enum TokenType {
	whitespace
	tag
	word
}

struct Token {
pub mut:
	kind        int
	value		string
}

pub struct State {
pub mut:
	id          string
	src			string
	idx			int
	stack		[]string
}

pub fn (mut state State) convert(src string) {
	state.src = src
	
}
pub fn (mut state State) preflight() {
	state.src = rx.replace('\r\n?', '\n', state.src)
	state.escape_special()
	
}

const escaped_chars = ['\\', '*', '#', '|', '!', '`', '>', ']', '[', '(', ')', ':', '+', '-', '_']

pub fn (mut state State) escape_special(){
	chd := '\x07\x07'

	for i in 0..escaped_chars.len {
		ch := escaped_chars[i]
		state.src = state.src.replace('\\' + ch , '${chd}${i}${chd}')
	}
}
pub fn (mut state State) unescape_special(){
	chd := '\x07\x07'
	for i in 0..escaped_chars.len {
		ch := escaped_chars[i]
		state.src = state.src.replace('${chd}${i}${chd}' , ch)
	}
}
pub fn (mut state State) next_token() {
	
}


