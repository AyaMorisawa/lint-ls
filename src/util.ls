filter-by-tag = (tag, lex) -->
	lex |> filter ([_tag, , , ]) -> _tag == tag

filter-by-value = (value, lex) -->
	lex |> filter ([, _value, , ]) -> _value == value

to-error = (error-type, lex) --> lex |> map ([, , line, ]) -> [line, error-type]

module.exports = {filter-by-tag, filter-by-value, to-error}
