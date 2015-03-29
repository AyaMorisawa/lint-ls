require! {
	LiveScript: {lex: parse-ls}
	'prelude-ls': {map, filter}
}

# String -> Object -> List
module.exports = (source, {
	allow-class = no
} = {}) ->
	lex = parse-ls source
	errors = (if allow-class then [] else check-class lex)

# String -> List -> List
filter-by-tag = (tag, lex) -->
	lex |> filter ([_tag, , , ]) -> _tag == tag


# List -> [Number, String]
check-class = (lex) ->
	lex |> filter-by-tag \CLASS |> map ([, , line, ]) -> [line, \class-is-not-allowed]
