require! {
	'prelude-ls': {map, filter}
}

first = (.0)

second = (.1)

third = (.2)

filter2 = (f, g, xss) --> xss |> filter ([a, b]) -> f a and g b

is-tag-by = (f, token) --> f first token

is-tag = (tag) -> is-tag-by (is tag)

is-value-by = (f, token) --> f second token

is-value = (value) -> is-value-by (is value)

to-error = (error-type, lex) --> lex |> map third |> map (line) -> [line + 1, error-type]

windowed = (size, xs) -->
	const last = xs.length - size
	if last < 0 then [] else [xs[i til i + size] for i from 0 to last]

is-pascal-case = (text) -> text is /^([A-Z][a-z]+)+$/

is-not-pascal-case = (is-pascal-case) >> (not)

module.exports = {first, second, third, filter2, is-tag-by, is-tag, is-value-by, is-value, to-error, windowed, is-pascal-case, is-not-pascal-case}
