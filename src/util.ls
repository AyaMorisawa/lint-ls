require! {
	'prelude-ls': {map, filter}
	'get-tuple': {fst, snd, trd}
}

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

is-not-pascal-case = (is-pascal-case) >> (not)

module.exports = {filter2, is-tag-by, is-tag, is-value-by, is-value, to-error, windowed, is-pascal-case, is-not-pascal-case}
