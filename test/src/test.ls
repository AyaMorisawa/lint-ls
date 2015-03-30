require! {
	chai: {should}
	'../../lib/': lint-ls
}

should!

describe \allow-class (...) ->
	it \no ->
		lint-ls 'class HogeHuga' {-allow-class} .should.have.deep.property '[0][1]' .equal \class-is-not-allowed
