require! {
	chai: {expect}
	'../../lib/': lint-ls
}

describe \allow-class (...) ->
	it \no ->
		lint-ls 'class HogeHuga' {-allow-class} |> expect >> (.to.have.deep.property '0.1' .equal \class-is-not-allowed)
