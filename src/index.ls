require! {
	LiveScript: {lex: parse-ls}
	'prelude-ls': {map, filter}
}

module.exports = (source, {
	allow-class = no
	allow-return = no
	allow-throw = no
	allow-break = no
	allow-continue = no
	allow-while = no
} = {}) ->
	lex = parse-ls source

	(if allow-class     then [] else check-class    lex) ++
	(if allow-return    then [] else check-return   lex) ++
	(if allow-throw     then [] else check-throw    lex) ++
	(if allow-break     then [] else check-break    lex) ++
	(if allow-continue  then [] else check-continue lex) ++
	(if allow-while     then [] else check-while    lex)

filter-by-tag = (tag, lex) -->
	lex |> filter ([_tag, , , ]) -> _tag == tag

filter-by-value = (value, lex) -->
	lex |> filter ([, _value, , ]) -> _value == value

to-error = (error-type, lex) --> lex |> map ([, , line, ]) -> [line, error-type]

check-class = (lex) ->
	lex |> filter-by-tag \CLASS |> to-error \class-is-not-allowed

check-return = (lex) ->
	lex |> filter-by-tag \HURL |> filter-by-value \return |> to-error \return-is-not-allowed

check-throw = (lex) ->
	lex |> filter-by-tag \HURL |> filter-by-value \throw |> to-error \throw-is-not-allowed

check-break = (lex) ->
	lex |> filter-by-tag \JUMP |> filter-by-value \break |> to-error \break-is-not-allowed

check-continue = (lex) ->
	lex |> filter-by-tag \JUMP |> filter-by-value \continue |> to-error \continue-is-not-allowed

check-while = (lex) ->
	lex |> filter-by-tag \WHILE |> to-error \while-is-not-allowed
