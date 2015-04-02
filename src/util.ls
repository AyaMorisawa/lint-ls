require! {
	'prelude-ls': {map, filter, sort-by, concat, id, fold1, camelize}
	'get-tuple': {fst, snd, trd}
}

check-rule = ([skip, check, target]) -> if skip then [] else check target

check-rules = (map check-rule) >> concat >> sort-by fst

filter-lex = (options) ->
	[
		[\tag is-tag]
		[\value is-value]
		[\tag-by is-tag-by]
		[\value-by is-value-by]
	]
	|> map ([name, f]) ->
		const option = options[camelize name]
		if option? then filter f option else id
	|> fold1 (>>)

filter2 = (f, g) --> filter ([a, b]) -> f a and g b

is-tag-by = (f, token) --> f fst token

is-tag = (tag) -> is-tag-by (is tag)

is-value-by = (f, token) --> f snd token

is-value = (value) -> is-value-by (is value)

to-error = (error-type, lex) --> lex |> map trd |> map (+ 1) |> map (line) -> [line, error-type]

windowed = (size, xs) -->
	const last = xs.length - size
	if last < 0 then [] else [xs[i til i + size] for i from 0 to last]

is-pascal-case = (is /^([A-Z][a-z]+)+$/)

is-not-pascal-case = is-pascal-case >> (not)

module.exports = {check-rules, filter-lex, filter2, is-tag-by, is-tag, is-value-by, is-value, to-error, windowed, is-pascal-case, is-not-pascal-case}
