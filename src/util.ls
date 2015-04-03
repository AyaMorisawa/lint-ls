require! {
	'prelude-ls': {map, filter, reject, sort-by, concat, id, fold1, camelize, obj-to-pairs, pairs-to-obj, zip-with}
	'get-tuple': {fst, snd, trd}
}

check-rule = ([skip, check, target]) -> if skip then [] else check target

check-rules = (map check-rule) >> concat >> sort-by fst

filter-lex = (options) ->
	get-depth = (options) ->
		| options.prev? => 1 + get-depth options.prev
		| _ => 0

	filter-n = (fs, xss) --> xss |> filter (zip-with (<|), fs) >> fold1 (and)

	flatten-options = (options) ->
		(if options.prev? then flatten-options options.prev else []) ++
		(options |> obj-to-pairs |> (reject ([key]) -> key in <[ prev next ]>) |> pairs-to-obj) ++
		(if options.next? then flatten-options options.next else [])

	generate-filter = (options) ->
		options
		|> obj-to-pairs
		|> map ([name, option]) -> {tag: is-tag, value: is-value, tag-by: is-tag-by, value-by: is-value-by}[name] option
		|> ((fs) -> (lex) -> fs |> map (<| lex) |> fold1 (and))

	depth = get-depth options

	(lex) ->
		lex
		|> windowed depth + 1
		|> filter-n (options |> flatten-options |> map generate-filter)
		|> map (.[depth])

is-tag-by = (fst >>)

is-tag = (is) >> is-tag-by

is-value-by = (snd >>)

is-value = (is) >> is-value-by

to-error = (error-type) -> (map trd) >> (map real-line) >> map (line) -> [line, error-type]

real-line = (+ 1)

windowed = (size, xs) -->
	const last = xs.length - size
	if last < 0 then [] else [xs[i til i + size] for i from 0 to last]

is-pascal-case = (is /^([A-Z][a-z]+)+$/)

is-not-pascal-case = is-pascal-case >> (not)

module.exports = {check-rules, filter-lex, to-error, is-pascal-case, is-not-pascal-case}
