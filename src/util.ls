require! {
	'prelude-ls': {filter, map}
}

filter-by-tag = (tag, lex) -->
	lex |> filter ([_tag, , , ]) -> _tag == tag

filter-by-value = (value, lex) -->
	lex |> filter ([, _value, , ]) -> _value == value

to-error = (error-type, lex) --> lex |> map ([, , line, ]) -> [line, error-type]

windowed = (size, xs) -->
	last = xs.length - size
	if last < 0 then [] else [xs[i til i + size] for i from 0 to last]

module.exports = {filter-by-tag, filter-by-value, to-error, windowed}
