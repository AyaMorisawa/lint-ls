require! {
	LiveScript: {lex: parse-ls}
	'prelude-ls': {filter, map, sort-by}
	'./util': {fst, snd, filter2, is-tag, is-value-by, is-value, to-error, windowed, is-not-pascal-case}
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
	allow-null = no
	allow-void = no
	allow-this = no
	allow-delete = no
	allow-eval = no
	enforce-pascal-case-class-name = yes
} = {}) ->
	const lex = parse-ls source

	(if allow-class     then [] else check-class    lex) ++
	(if allow-return    then [] else check-return   lex) ++
	(if allow-throw     then [] else check-throw    lex) ++
	(if allow-break     then [] else check-break    lex) ++
	(if allow-continue  then [] else check-continue lex) ++
	(if allow-while     then [] else check-while    lex) ++
	(if allow-case      then [] else check-case     lex) ++
	(if allow-default   then [] else check-default  lex) ++
	(if allow-null      then [] else check-null     lex) ++
	(if allow-void      then [] else check-void     lex) ++
	(if allow-this      then [] else check-this     lex) ++
	(if allow-delete    then [] else check-delete   lex) ++
	(if allow-eval      then [] else check-eval     lex) ++
	(unless enforce-pascal-case-class-name then [] else check-pascal-case-class-name lex)
	|> sort-by fst

check-class = (lex) ->
	lex |> filter is-tag \CLASS |> to-error \class-is-not-allowed

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
