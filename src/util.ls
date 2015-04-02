require! {
	'prelude-ls': {map, filter, sort-by, concat, id}
	'get-tuple': {fst, snd, trd}
}

check-rule = ([skip, check, target]) -> if skip then [] else check target

check-rules = (map check-rule) >> concat >> sort-by fst

filter-lex = (option, lex) -->
	lex
	|> if option.tag? then filter is-tag option.tag else id
	|> if option.value? then filter is-value option.value else id
	|> if option.tag-by? then filter is-tag-by option.tag-by else id
	|> if option.value-by? then filter is-value-by option.value-by else id

filter2 = (f, g, xss) --> xss |> filter ([a, b]) -> f a and g b

is-tag-by = (f, token) --> f fst token

is-tag = (tag) -> is-tag-by (is tag)

is-value-by = (f, token) --> f snd token

is-value = (value) -> is-value-by (is value)

to-error = (error-type, lex) --> lex |> map trd |> map (+ 1) |> map (line) -> [line, error-type]

windowed = (size, xs) -->
	const last = xs.length - size
	if last < 0 then [] else [xs[i til i + size] for i from 0 to last]

is-pascal-case = (text) -> text is /^([A-Z][a-z]+)+$/

is-not-pascal-case = is-pascal-case >> (not)

module.exports = {check-rules, filter-lex, filter2, is-tag-by, is-tag, is-value-by, is-value, to-error, windowed, is-pascal-case, is-not-pascal-case}
