require! {
	LiveScript: {lex: parse-ls}
	'prelude-ls': {filter, map, sort-by}
	'get-tuple': {fst, snd}
	'./util': {check-rules, filter2, is-tag, is-value-by, is-value, to-error, windowed, is-not-pascal-case}
}

module.exports = (source, {
	allow-class = no
	allow-new = no
	allow-return = no
	allow-throw = no
	allow-break = no
	allow-continue = no
	allow-while = no
	allow-case = yes
	allow-default = no
	allow-null = no
	allow-void = no
	allow-this = no
	allow-delete = no
	allow-eval = no
	enforce-pascal-case-class-name = yes
} = {}) ->
	const lex = parse-ls source

	check-rules [
		[allow-class, check-class, lex]
		[allow-new, check-new, lex]
		[allow-return, check-return, lex]
		[allow-throw, check-throw, lex]
		[allow-break, check-break, lex]
		[allow-continue, check-continue, lex]
		[allow-while, check-while, lex]
		[allow-case, check-case, lex]
		[allow-default, check-default, lex]
		[allow-null, check-null, lex]
		[allow-void, check-void, lex]
		[allow-this, check-this, lex]
		[allow-delete, check-delete, lex]
		[allow-eval, check-eval, lex]
		[!enforce-pascal-case-class-name, check-pascal-case-class-name, lex]
	]

check-class = (lex) ->
	lex |> filter is-tag \CLASS |> to-error \class-is-not-allowed

check-new = (lex) ->
	lex |> filter is-tag \UNARY |> filter is-value \new |> to-error \new-is-not-allowed

check-return = (lex) ->
	lex |> filter is-tag \HURL |> filter is-value \return |> to-error \return-is-not-allowed

check-throw = (lex) ->
	lex |> filter is-tag \HURL |> filter is-value \throw |> to-error \throw-is-not-allowed

check-break = (lex) ->
	lex |> filter is-tag \JUMP |> filter is-value \break |> to-error \break-is-not-allowed

check-continue = (lex) ->
	lex |> filter is-tag \JUMP |> filter is-value \continue |> to-error \continue-is-not-allowed

check-while = (lex) ->
	lex |> filter is-tag \WHILE |> to-error \while-is-not-allowed

check-case = (lex) ->
	lex |> filter is-tag \CASE |> filter is-value \case |> to-error \case-is-not-allowed

check-default = (lex) ->
	lex |> filter is-tag \DEFAULT |> to-error \default-is-not-allowed

check-null = (lex) ->
	lex |> filter is-tag \LITERAL |> filter is-value \null |> to-error \null-is-not-allowed

check-void = (lex) ->
	lex |> filter is-tag \LITERAL |> filter is-value \void |> to-error \void-is-not-allowed

check-this = (lex) ->
	lex |> filter is-tag \LITERAL |> filter is-value \this |> to-error \this-is-not-allowed

check-delete = (lex) ->
	lex |> filter is-tag \UNARY |> filter is-value-by (in <[ delete jsdelete ]>) |> to-error \delete-is-not-allowed

check-eval = (lex) ->
	lex |> filter is-tag \LITERAL |> filter is-value \eval |> to-error \eval-is-not-allowed

check-pascal-case-class-name = (lex) ->
	lex
	|> windowed 2 |> filter2 (is-tag \CLASS), (is-value-by is-not-pascal-case)
	|> map snd |> to-error \class-name-must-be-pascal-case
