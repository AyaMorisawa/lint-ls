require! {
	LiveScript: {lex: parse-ls}
	'prelude-ls': {map, filter}
	'./util': {filter-by-tag, filter-by-value, to-error}
}

module.exports = (source, {
	allow-class = no
	allow-return = no
	allow-throw = no
	allow-break = no
	allow-continue = no
	allow-while = no
	allow-case = no
	allow-default = no
} = {}) ->
	lex = parse-ls source

	(if allow-class     then [] else check-class    lex) ++
	(if allow-return    then [] else check-return   lex) ++
	(if allow-throw     then [] else check-throw    lex) ++
	(if allow-break     then [] else check-break    lex) ++
	(if allow-continue  then [] else check-continue lex) ++
	(if allow-while     then [] else check-while    lex) ++
	(if allow-case      then [] else check-case     lex) ++
	(if allow-default   then [] else check-default  lex)

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

check-case = (lex) ->
	lex |> filter-by-tag \CASE |> filter-by-value \case |> to-error \case-is-not-allowed

check-default = (lex) ->
	lex |> filter-by-tag \DEFAULT |> to-error \default-is-not-allowed
