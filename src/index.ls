require! {
	LiveScript: {lex: parse-ls}
	'prelude-ls': {filter, map}
	'get-tuple': {snd}
	'./util': {check-rules, filter-lex, filter2, is-tag, is-value-by, to-error, windowed, is-not-pascal-case}
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
	lex |> filter-lex {tag: \CLASS} |> to-error \class-is-not-allowed

check-new = (lex) ->
	lex |> filter-lex {tag: \UNARY, value: \new} |> to-error \new-is-not-allowed

check-return = (lex) ->
	lex |> filter-lex {tag: \HURL, value: \return} |> to-error \return-is-not-allowed

check-throw = (lex) ->
	lex |> filter-lex {tag: \HURL, value: \throw} |> to-error \throw-is-not-allowed

check-break = (lex) ->
	lex |> filter-lex {tag: \JUMP, value: \break} |> to-error \break-is-not-allowed

check-continue = (lex) ->
	lex |> filter-lex {tag: \JUMP, value: \continue} |> to-error \continue-is-not-allowed

check-while = (lex) ->
	lex |> filter-lex {tag: \WHILE} |> to-error \while-is-not-allowed

check-case = (lex) ->
	lex |> filter-lex {tag: \CASE, value: \case} |> to-error \case-is-not-allowed

check-default = (lex) ->
	lex |> filter-lex {tag: \DEFAULT} |> to-error \default-is-not-allowed

check-null = (lex) ->
	lex |> filter-lex {tag: \LITERAL, value: \null} |> to-error \null-is-not-allowed

check-void = (lex) ->
	lex |> filter-lex {tag: \LITERAL, value: \void} |> to-error \void-is-not-allowed

check-this = (lex) ->
	lex |> filter-lex {tag: \LITERAL, value: \this} |> to-error \this-is-not-allowed

check-delete = (lex) ->
	lex |> filter-lex {tag: \UNARY, value-by: (in <[ delete jsdelete ]>)} |> to-error \delete-is-not-allowed

check-eval = (lex) ->
	lex |> filter-lex {tag: \LITERAL, value: \eval} |> to-error \eval-is-not-allowed

check-pascal-case-class-name = (lex) ->
	lex
	|> windowed 2 |> filter2 (is-tag \CLASS), (is-value-by is-not-pascal-case)
	|> map snd |> to-error \class-name-must-be-pascal-case
