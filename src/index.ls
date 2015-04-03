require! {
	'./default-options'
	'./util': {parse-ls, check-rules, filter-lex, to-error, is-not-pascal-case}
}

module.exports = (source, options) ->
	const {
		allow-class
		allow-new
		allow-return
		allow-throw
		allow-break
		allow-continue
		allow-while
		allow-case
		allow-default
		allow-null
		allow-void
		allow-this
		allow-delete
		allow-eval
		enforce-pascal-case-class-name
	} = default-options with options

	{ast, tokens, lex} = parse-ls source

	check-rules [
		* allow-class, check-class, lex
		* allow-new, check-new, lex
		* allow-return, check-return, lex
		* allow-throw, check-throw, lex
		* allow-break, check-break, lex
		* allow-continue, check-continue, lex
		* allow-while, check-while, lex
		* allow-case, check-case, lex
		* allow-default, check-default, lex
		* allow-null, check-null, lex
		* allow-void, check-void, lex
		* allow-this, check-this, lex
		* allow-delete, check-delete, lex
		* allow-eval, check-eval, lex
		* !enforce-pascal-case-class-name, check-pascal-case-class-name, lex
	]

check-class = (filter-lex {tag: \CLASS}) >> to-error \class-is-not-allowed
check-new = (filter-lex {tag: \UNARY, value: \new}) >> to-error \new-is-not-allowed
check-return = (filter-lex {tag: \HURL, value: \return}) >> to-error \return-is-not-allowed
check-throw = (filter-lex {tag: \HURL, value: \throw}) >> to-error \throw-is-not-allowed
check-break = (filter-lex {tag: \JUMP, value: \break}) >> to-error \break-is-not-allowed
check-continue = (filter-lex {tag: \JUMP, value: \continue}) >> to-error \continue-is-not-allowed
check-while = (filter-lex {tag: \WHILE}) >> to-error \while-is-not-allowed
check-case = (filter-lex {tag: \CASE, value: \case}) >> to-error \case-is-not-allowed
check-default = (filter-lex {tag: \DEFAULT}) >> to-error \default-is-not-allowed
check-null = (filter-lex {tag: \LITERAL, value: \null}) >> to-error \null-is-not-allowed
check-void = (filter-lex {tag: \LITERAL, value: \void}) >> to-error \void-is-not-allowed
check-this = (filter-lex {tag: \LITERAL, value: \this}) >> to-error \this-is-not-allowed
check-delete = (filter-lex {tag: \UNARY, value-by: (in <[ delete jsdelete ]>)}) >> to-error \delete-is-not-allowed
check-eval = (filter-lex {tag: \LITERAL, value: \eval}) >> to-error \eval-is-not-allowed
check-pascal-case-class-name = (filter-lex {prev: {tag: \CLASS}, value-by: is-not-pascal-case}) >> to-error \class-name-must-be-pascal-case
